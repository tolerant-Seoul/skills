# Backend Verification Patterns

## SIWE (Sign-In with Ethereum) Verification

```typescript
// app/api/auth/verify/route.ts
import { verifySiweMessage } from '@worldcoin/minikit-js'
import { NextRequest, NextResponse } from 'next/server'

export async function POST(req: NextRequest) {
  try {
    const { payload, nonce } = await req.json()

    // Verify the SIWE message
    const validMessage = await verifySiweMessage(payload, nonce)

    if (!validMessage.isValid) {
      return NextResponse.json(
        { error: 'Invalid signature' },
        { status: 401 }
      )
    }

    const { address, username, profilePictureUrl } = validMessage

    // Create session or JWT
    const session = await createSession({
      address,
      username,
      profilePictureUrl,
    })

    return NextResponse.json({ success: true, session })
  } catch (error) {
    return NextResponse.json(
      { error: 'Verification failed' },
      { status: 500 }
    )
  }
}
```

## World ID Proof Verification

```typescript
// app/api/verify/route.ts
import { verifyCloudProof, IVerifyResponse } from '@worldcoin/minikit-js'
import { NextRequest, NextResponse } from 'next/server'

export async function POST(req: NextRequest) {
  try {
    const payload = await req.json()

    const verifyRes = await verifyCloudProof(
      payload,
      process.env.WORLD_APP_ID!,
      process.env.WORLD_ACTION_ID!,
      payload.signal // Optional
    ) as IVerifyResponse

    if (!verifyRes.success) {
      return NextResponse.json(
        { error: verifyRes.error || 'Verification failed' },
        { status: 400 }
      )
    }

    // Store nullifier_hash to prevent duplicate verifications
    const nullifierHash = payload.nullifier_hash

    // Check if already verified
    const existing = await db.verification.findUnique({
      where: { nullifierHash }
    })

    if (existing) {
      return NextResponse.json(
        { error: 'Already verified' },
        { status: 400 }
      )
    }

    // Save verification
    await db.verification.create({
      data: {
        nullifierHash,
        verifiedAt: new Date(),
      }
    })

    return NextResponse.json({ success: true, verified: true })
  } catch (error) {
    return NextResponse.json(
      { error: 'Verification failed' },
      { status: 500 }
    )
  }
}
```

## Payment Verification

```typescript
// app/api/verify-payment/route.ts
import { NextRequest, NextResponse } from 'next/server'

export async function POST(req: NextRequest) {
  try {
    const payload = await req.json()

    if (payload.status !== 'success') {
      return NextResponse.json(
        { error: 'Payment not successful' },
        { status: 400 }
      )
    }

    // Verify transaction on-chain
    const txResponse = await fetch(
      `https://developer.worldcoin.org/api/v2/minikit/transaction/${payload.transaction_id}`,
      {
        headers: {
          'Authorization': `Bearer ${process.env.WORLD_API_KEY}`,
        },
      }
    )

    const txData = await txResponse.json()

    if (txData.status !== 'confirmed') {
      return NextResponse.json(
        { error: 'Transaction not confirmed' },
        { status: 400 }
      )
    }

    // Process payment
    await processPayment({
      reference: payload.reference,
      transactionId: payload.transaction_id,
      hash: txData.hash,
    })

    return NextResponse.json({ success: true })
  } catch (error) {
    return NextResponse.json(
      { error: 'Payment verification failed' },
      { status: 500 }
    )
  }
}
```

## Nonce Management

```typescript
// lib/nonce.ts
import { Redis } from '@upstash/redis'

const redis = new Redis({
  url: process.env.UPSTASH_REDIS_URL!,
  token: process.env.UPSTASH_REDIS_TOKEN!,
})

export async function createNonce(): Promise<string> {
  const nonce = crypto.randomUUID().replace(/-/g, '')

  // Store with 5 minute expiry
  await redis.set(`nonce:${nonce}`, 'valid', { ex: 300 })

  return nonce
}

export async function verifyNonce(nonce: string): Promise<boolean> {
  const value = await redis.get(`nonce:${nonce}`)

  if (value === 'valid') {
    // Delete after use (one-time use)
    await redis.del(`nonce:${nonce}`)
    return true
  }

  return false
}
```

## Environment Variables

```env
# Required for backend verification
WORLD_APP_ID=app_xxx
WORLD_API_KEY=your-api-key
WORLD_ACTION_ID=your-action-id

# Database
DATABASE_URL=postgresql://...

# Redis (for nonce management)
UPSTASH_REDIS_URL=https://...
UPSTASH_REDIS_TOKEN=...
```

## Security Best Practices

1. **Always verify on backend** - Never trust frontend-only verification
2. **Use one-time nonces** - Prevent replay attacks
3. **Store nullifier hashes** - Prevent duplicate verifications
4. **Verify transactions on-chain** - Don't trust client-side payment status
5. **Use HTTPS only** - All API calls must be over HTTPS
6. **Rate limit endpoints** - Prevent abuse
7. **Validate all inputs** - Sanitize and validate request data
