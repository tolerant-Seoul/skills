# MiniKit Commands Quick Reference

## Authentication

### walletAuth
```typescript
const { finalPayload } = await MiniKit.commandsAsync.walletAuth({
  nonce: crypto.randomUUID().replace(/-/g, ""),
  expirationTime: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
  statement: 'Sign in to My App',
})
```

### verify (World ID)
```typescript
const { finalPayload } = await MiniKit.commandsAsync.verify({
  action: 'my-action-id',
  signal: userId,
  verification_level: VerificationLevel.Orb, // or Device
})
```

## Payments & Transactions

### pay
```typescript
import { Tokens, tokenToDecimals } from '@worldcoin/minikit-js'

const { finalPayload } = await MiniKit.commandsAsync.pay({
  reference: crypto.randomUUID(),
  to: '0xRecipientAddress',
  tokens: [
    { symbol: Tokens.WLD, token_amount: tokenToDecimals(1, Tokens.WLD).toString() },
    { symbol: Tokens.USDC, token_amount: tokenToDecimals(5, Tokens.USDC).toString() },
  ],
  description: 'Payment description',
})
```

### sendTransaction
```typescript
const { finalPayload } = await MiniKit.commandsAsync.sendTransaction({
  transaction: [
    {
      address: '0xContractAddress',
      abi: ContractABI,
      functionName: 'functionName',
      args: [arg1, arg2],
    },
  ],
})
```

### signMessage
```typescript
const { finalPayload } = await MiniKit.commandsAsync.signMessage({
  message: 'Message to sign',
})
```

## Social & Sharing

### shareContacts
```typescript
const payload = await MiniKit.commandsAsync.shareContacts({
  isMultiSelectEnabled: true,
  inviteMessage: 'Join me!',
})
// payload.contacts: [{ username, walletAddress, profilePictureUrl }]
```

### share
```typescript
await MiniKit.commandsAsync.share({
  title: 'Title',
  text: 'Description',
  url: 'https://...',
})
```

### chat
```typescript
const { finalPayload } = await MiniKit.commandsAsync.chat({
  message: 'Message content',
  to: ['username1', '0xAddress...'],
})
```

## Permissions & Notifications

### getPermissions
```typescript
const { permissions } = await MiniKit.commandsAsync.getPermissions()
// permissions.notifications, permissions.contacts, etc.
```

### requestPermission
```typescript
await MiniKit.commandsAsync.requestPermission({
  permission: Permission.Notifications,
})
```

## UX Enhancements

### sendHapticFeedback
```typescript
MiniKit.commands.sendHapticFeedback({
  hapticsType: 'impact',  // 'impact' | 'notification' | 'selectionChanged'
  style: 'medium',        // impact: 'light'|'medium'|'heavy'
                          // notification: 'success'|'warning'|'error'
})
```

### showProfileCard
```typescript
MiniKit.showProfileCard({
  username: 'username',
  walletAddress: '0x...',
})
```

## User Lookup

```typescript
const user = await MiniKit.getUserByAddress('0x...')
const user = await MiniKit.getUserByUsername('username')
// Returns: { username, walletAddress, profilePictureUrl }
```

## Status Codes

| Status | Description |
|--------|-------------|
| `success` | Operation completed |
| `user_rejected` | User cancelled |
| `invalid_proof` | Verification failed |
| `already_verified` | Already verified |
| `send_failed` | Send operation failed |
| `generic_error` | General error |
