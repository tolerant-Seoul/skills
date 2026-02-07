# World App Deep Links

## Mini App Links

### Universal Link (Web + App)
```
https://world.org/mini-app?app_id={app_id}&path={encoded_path}
```

### World App Deep Link (App Only)
```
worldapp://mini-app?app_id={app_id}&path={encoded_path}
```

### Examples
```typescript
// Basic mini app link
https://world.org/mini-app?app_id=app_abc123

// With path
https://world.org/mini-app?app_id=app_abc123&path=%2Finvite%3Fref%3Duser123

// Generate in code
function generateMiniAppLink(path: string): string {
  const appId = process.env.NEXT_PUBLIC_APP_ID
  const encodedPath = encodeURIComponent(path)
  return `https://world.org/mini-app?app_id=${appId}&path=${encodedPath}`
}
```

## Chat Links

### Open Chat
```
https://world.org/chat
worldapp://chat
```

### Chat with User
```
https://world.org/profile?username={username}&action=chat
https://world.org/profile?address={wallet_address}&action=chat
```

### Request Payment
```
https://world.org/profile?username={username}&action=request
https://world.org/profile?address={wallet_address}&action=request
```

### Send Payment
```
https://world.org/profile?username={username}&action=pay
https://world.org/profile?address={wallet_address}&action=pay
```

## Android Deferred Deep Links

For users who don't have World App installed:

```
https://play.google.com/store/apps/details?id=com.worldcoin&referrer=app_id%3D{app_id}%26path%3D{encoded_path}
```

## Invite Link Generator

```typescript
function generateInviteLink(userId: string): string {
  const baseUrl = 'https://world.org/mini-app'
  const appId = process.env.NEXT_PUBLIC_APP_ID
  const path = encodeURIComponent(`/invite?ref=${userId}`)
  return `${baseUrl}?app_id=${appId}&path=${path}`
}

// Usage
const inviteLink = generateInviteLink('user123')
// https://world.org/mini-app?app_id=app_abc&path=%2Finvite%3Fref%3Duser123
```

## Share with Deep Link

```typescript
async function shareInvite(userId: string) {
  const inviteLink = generateInviteLink(userId)

  await MiniKit.commandsAsync.share({
    title: 'Join me on MyApp!',
    text: 'Use my invite link to get bonus rewards!',
    url: inviteLink,
  })
}
```

## Notification Deep Links

```typescript
// In notification payload
{
  "mini_app_path": "worldapp://mini-app?app_id=app_xxx&path=/rewards"
}
```

## URL Parameters

| Parameter | Required | Description |
|-----------|----------|-------------|
| `app_id` | Yes | Your app ID from Developer Portal |
| `path` | No | URL-encoded path within your app |
| `username` | For profile | Target user's username |
| `address` | For profile | Target user's wallet address |
| `action` | For profile | `chat`, `request`, or `pay` |
