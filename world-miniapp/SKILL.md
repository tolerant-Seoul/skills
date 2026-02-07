---
name: world-miniapp
description: World Mini App development skill for World ID verification, World Chain transactions, MiniKit SDK integration, payments, notifications, and contacts. Use when building World Mini Apps, integrating World ID, implementing payments with WLD/USDC, or using any MiniKit features. Activate with /world command.
---

# World Mini App Development Skill

Use this skill when developing World Mini Apps, integrating World ID, World Chain, or using MiniKit features. Activate with `/world` or when the user mentions World App, MiniKit, World ID, or World Chain.

---

## Overview

World Mini Apps are native-like applications running inside World App. They provide:
- **World ID**: Privacy-preserving identity verification (ZK proofs)
- **World Chain**: L2 blockchain with gas sponsorship
- **MiniKit**: SDK for payments, auth, notifications, contacts

---

## MiniKit Setup

### Installation

```bash
npm install @worldcoin/minikit-js
# or
pnpm add @worldcoin/minikit-js
```

### Provider Setup (Next.js)

```tsx
// app/providers.tsx
'use client'
import { MiniKit } from '@worldcoin/minikit-js'
import { useEffect, ReactNode } from 'react'

export function MiniKitProvider({ children }: { children: ReactNode }) {
  useEffect(() => {
    MiniKit.install()
  }, [])

  return <>{children}</>
}

// app/layout.tsx
import { MiniKitProvider } from './providers'

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        <MiniKitProvider>{children}</MiniKitProvider>
      </body>
    </html>
  )
}
```

### Check MiniKit Availability

```typescript
if (MiniKit.isInstalled()) {
  // MiniKit is available
}
```

---

## Commands Reference

### 1. Wallet Authentication (SIWE)

Authenticate users with Sign-In with Ethereum, providing wallet address, username, profile picture.

```typescript
// Frontend
const nonce = crypto.randomUUID().replace(/-/g, "")

const { finalPayload } = await MiniKit.commandsAsync.walletAuth({
  nonce: nonce,
  expirationTime: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
  statement: 'Sign in to My App',
})

if (finalPayload.status === 'success') {
  // Send to backend for verification
  await fetch('/api/auth/verify', {
    method: 'POST',
    body: JSON.stringify({ payload: finalPayload, nonce }),
  })
}
```

```typescript
// Backend verification
import { verifySiweMessage } from '@worldcoin/minikit-js'

const validMessage = await verifySiweMessage(payload, nonce)
if (validMessage.isValid) {
  const { address, username, profilePictureUrl } = validMessage
  // Create session
}
```

### 2. World ID Verification (Incognito Actions)

Verify user identity with ZK proofs. Supports verification levels: `Orb` (biometric) or `Device`.

```typescript
// Frontend
const { finalPayload } = await MiniKit.commandsAsync.verify({
  action: 'my-action-id',  // Must match Developer Portal
  signal: userId,          // Optional: bind to specific data
  verification_level: VerificationLevel.Orb,
})

if (finalPayload.status === 'success') {
  await fetch('/api/verify', {
    method: 'POST',
    body: JSON.stringify(finalPayload),
  })
}
```

```typescript
// Backend verification
import { verifyCloudProof } from '@worldcoin/minikit-js'

const verifyRes = await verifyCloudProof(
  payload,
  process.env.WORLD_APP_ID,
  'my-action-id',
  signal // Optional
)

if (verifyRes.success) {
  // User is verified human
  const nullifierHash = payload.nullifier_hash // Unique per action
}
```

**API Endpoint:**
```
POST https://developer.worldcoin.org/api/v2/verify/{app_id}
```

### 3. Payments

Process WLD and USDC payments with gas sponsorship.

```typescript
import { Tokens, tokenToDecimals } from '@worldcoin/minikit-js'

const { finalPayload } = await MiniKit.commandsAsync.pay({
  reference: crypto.randomUUID(), // Unique payment reference
  to: '0xRecipientAddress',
  tokens: [
    {
      symbol: Tokens.WLD,
      token_amount: tokenToDecimals(1, Tokens.WLD).toString(),
    },
    {
      symbol: Tokens.USDC,
      token_amount: tokenToDecimals(5, Tokens.USDC).toString(),
    },
  ],
  description: 'Payment for service',
})

if (finalPayload.status === 'success') {
  // Verify on backend - ALWAYS verify payments server-side
  await fetch('/api/verify-payment', {
    method: 'POST',
    body: JSON.stringify(finalPayload),
  })
}
```

**Limits:**
- Minimum transfer: $0.1 per token
- Unavailable in: Indonesia, Philippines

### 4. Smart Contract Transactions

Read/write to World Chain smart contracts.

```typescript
const { finalPayload } = await MiniKit.commandsAsync.sendTransaction({
  transaction: [
    {
      address: '0xContractAddress',
      abi: ContractABI,
      functionName: 'mint',
      args: ['0xUserAddress', 100],
    },
  ],
})
```

**Limits:**
- 500 free transactions per user per day
- 1 million gas limit per transaction
- Contracts must be whitelisted in Developer Portal

### 5. Sign Message (EIP-191)

Create verifiable signatures.

```typescript
const { finalPayload } = await MiniKit.commandsAsync.signMessage({
  message: 'I agree to the terms of service',
})

// Verify signature on backend using ethers or viem
```

### 6. Share Contacts

Privacy-preserving contact selection.

```typescript
const payload = await MiniKit.commandsAsync.shareContacts({
  isMultiSelectEnabled: true,
  inviteMessage: 'Join me on this app!',
})

if (payload.status === 'success') {
  payload.contacts.forEach(contact => {
    console.log(contact.username, contact.walletAddress, contact.profilePictureUrl)
  })
}
```

### 7. Send Notifications

Push notifications to users (requires permission).

```typescript
// Step 1: Check permission
const { permissions } = await MiniKit.commandsAsync.getPermissions()

// Step 2: Request permission
if (!permissions.notifications) {
  await MiniKit.commandsAsync.requestPermission({
    permission: Permission.Notifications,
  })
}

// Step 3: Send via API (backend)
await fetch('https://developer.worldcoin.org/api/v2/minikit/send-notification', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${API_KEY}`,
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({
    app_id: 'your_app_id',
    wallet_addresses: ['0x123...'],
    localisations: [
      { language: 'en', title: '🎉 Reward Ready', message: 'Claim now!' },
      { language: 'ko', title: '🎉 리워드 준비됨', message: '지금 받으세요!' },
    ],
    mini_app_path: 'worldapp://mini-app?app_id=your_app_id&path=/rewards',
  }),
})
```

**Limits:** 40 notifications per 4 hours for unverified apps.

### 8. Chat Command

Share messages via World Chat.

```typescript
const { finalPayload } = await MiniKit.commandsAsync.chat({
  message: 'Check out this amazing app!',
  to: ['username1', '0xAddress...'],
})
```

### 9. Share Command

Native device share drawer.

```typescript
await MiniKit.commandsAsync.share({
  title: 'Invite Link',
  text: 'Join me on this app!',
  url: 'https://world.org/mini-app?app_id=xxx&path=/invite',
})
```

### 10. Haptic Feedback

Tactile feedback for interactions.

```typescript
MiniKit.commands.sendHapticFeedback({
  hapticsType: 'impact',  // 'impact' | 'notification' | 'selectionChanged'
  style: 'medium',        // 'light' | 'medium' | 'heavy' (for impact)
                          // 'success' | 'warning' | 'error' (for notification)
})
```

### 11. Show Profile Card

Display user profile overlay.

```typescript
MiniKit.showProfileCard({
  username: 'andy',
  walletAddress: '0x1234...',
})
```

### 12. Get User Info

```typescript
const user = await MiniKit.getUserByAddress('0x1234...')
const user = await MiniKit.getUserByUsername('andy')
// Returns: { username, walletAddress, profilePictureUrl }
```

---

## API Endpoints

### Verify Proof
```
POST https://developer.worldcoin.org/api/v2/verify/{app_id}
```

### Create Incognito Action
```
POST https://developer.worldcoin.org/api/v2/create-action/{app_id}
```

### Get Token Prices
```
GET https://developer.worldcoin.org/public/v1/miniapps/prices
```

### Get Transaction
```
GET https://developer.worldcoin.org/api/v2/minikit/transaction/{transaction_id}
```

### Get Transaction Debug URL (Tenderly)
```
GET https://developer.worldcoin.org/api/v2/minikit/transaction/debug
```

### Get User Grant Cycle
```
GET https://developer.worldcoin.org/api/v2/minikit/user-grant-cycle
```

### Send Notification
```
POST https://developer.worldcoin.org/api/v2/minikit/send-notification
```

---

## Deep Links

### Universal Links
```
https://world.org/mini-app?app_id={app_id}&path={encoded_path}
```

### World App Deep Links
```
worldapp://mini-app?app_id={app_id}&path={encoded_path}
```

### Chat Links
```
https://world.org/chat
https://world.org/profile?username=andy&action=chat
https://world.org/profile?address=0x...&action=pay
```

### Generate Invite Link
```typescript
function generateInviteLink(userId: string): string {
  const baseUrl = 'https://world.org/mini-app'
  const appId = process.env.NEXT_PUBLIC_APP_ID
  const path = encodeURIComponent(`/invite?ref=${userId}`)
  return `${baseUrl}?app_id=${appId}&path=${path}`
}
```

---

## Growth & Analytics

### Essential Events (6 lines)
```typescript
track('app_open')
track('signup', { method: 'world_id' })
track('first_value', { action: 'completed' })
track('invite_sent')
track('invite_accepted')
track('notification_open')
```

### Target Metrics
- Signup-to-first-value: ≥40%
- D1 retention: ≥25%
- Invite acceptance: ≥15%
- Push notification open rate: ≥15%

### Notification Quality Thresholds
- <10% open rate: Paused for 1 week
- 10%+: Badge displayed
- 25%+: "Excellent" tier

---

## Gamification Patterns

### Daily Streaks
```typescript
const updateStreak = (lastActive: Date, currentStreak: number) => {
  const daysSince = Math.floor((Date.now() - lastActive.getTime()) / 86400000)
  return daysSince === 1 ? currentStreak + 1 : 1
}
```

### Referral System
```typescript
async function processReferral(newUserId: string, referrerCode: string) {
  const referrer = await getUserByCode(referrerCode)
  await Promise.all([
    creditUser(referrer.id, { type: 'referral_bonus', amount: 100 }),
    creditUser(newUserId, { type: 'signup_bonus', amount: 50 }),
  ])
}
```

---

## Design Guidelines

### Mobile-First CSS
```css
html, body {
  width: 100vw;
  height: 100vh;
  overscroll-behavior: none;
  overflow: hidden;
}
```

### Spacing Standards
- Default padding: 24px
- Header-to-content: 16px
- Inter-element: 16px

### Performance Targets
- Initial load: 2-3 seconds max
- Subsequent actions: <1 second
- Always show loading feedback

### UI Kit
```bash
npm install @worldcoin/mini-apps-ui-kit-react
```

### Localization Priority
1. English (en)
2. Spanish (es)
3. Thai (th)
4. Japanese (ja)
5. Korean (ko)
6. Portuguese (pt)

---

## Prohibited Practices

- Chance-based games (RNG prizes)
- Paid memberships increasing yield
- Token pre-sales
- NFT purchases (iOS)
- Using "official" World branding
- Using World logo

---

## Environment Variables

```env
# Required
NEXT_PUBLIC_APP_ID=app_xxx
NEXT_PUBLIC_WORLD_ACTION_ID=your-action-id

# Backend
WORLD_APP_ID=app_xxx
WORLD_API_KEY=your-api-key
```

---

## Error Codes

| Code | Description |
|------|-------------|
| `user_rejected` | User cancelled the action |
| `invalid_proof` | Proof verification failed |
| `already_verified` | User already verified for this action |
| `send_failed` | Message/notification send failed |
| `generic_error` | General error |

---

## Best Practices

1. **Always verify on backend** - Never trust frontend-only verification
2. **Handle all error cases** - Check `finalPayload.status`
3. **Use haptic feedback** - Enhance UX with tactile responses
4. **Implement loading states** - Show feedback during async operations
5. **Cache user data** - Reduce API calls for user info
6. **Use deep links** - Enable seamless app navigation
7. **Track essential events** - Monitor key metrics
8. **Localize notifications** - Support multiple languages
9. **Test on real device** - MiniKit requires World App environment
10. **Whitelist contracts** - Register contracts in Developer Portal

---

## Quick Reference

```typescript
// Auth flow
const { finalPayload } = await MiniKit.commandsAsync.walletAuth({ nonce, ... })

// Verify identity
const { finalPayload } = await MiniKit.commandsAsync.verify({ action, ... })

// Payment
const { finalPayload } = await MiniKit.commandsAsync.pay({ to, tokens, ... })

// Transaction
const { finalPayload } = await MiniKit.commandsAsync.sendTransaction({ transaction })

// Share
await MiniKit.commandsAsync.share({ title, text, url })

// Contacts
const { contacts } = await MiniKit.commandsAsync.shareContacts({ ... })

// Haptics
MiniKit.commands.sendHapticFeedback({ hapticsType, style })

// User lookup
const user = await MiniKit.getUserByAddress(address)
```
