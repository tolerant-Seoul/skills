# World Developer API Endpoints

Base URL: `https://developer.worldcoin.org`

## Verification

### Verify Proof
```
POST /api/v2/verify/{app_id}

Headers:
  Authorization: Bearer {API_KEY}
  Content-Type: application/json

Body:
{
  "nullifier_hash": "0x...",
  "merkle_root": "0x...",
  "proof": "0x...",
  "verification_level": "orb",
  "action": "action-id",
  "signal": "optional-signal"
}

Response:
{
  "success": true,
  "nullifier_hash": "0x..."
}
```

### Create Incognito Action
```
POST /api/v2/create-action/{app_id}

Headers:
  Authorization: Bearer {API_KEY}
  Content-Type: application/json

Body:
{
  "name": "action-name",
  "description": "Action description",
  "max_verifications": 1
}
```

## Mini App APIs

### Send Notification
```
POST /api/v2/minikit/send-notification

Headers:
  Authorization: Bearer {API_KEY}
  Content-Type: application/json

Body:
{
  "app_id": "app_xxx",
  "wallet_addresses": ["0x123...", "0x456..."],
  "localisations": [
    {
      "language": "en",
      "title": "Notification Title",
      "message": "Notification message with ${username}"
    },
    {
      "language": "ko",
      "title": "알림 제목",
      "message": "알림 메시지"
    }
  ],
  "mini_app_path": "worldapp://mini-app?app_id=app_xxx&path=/page"
}

Response:
{
  "success": true,
  "sent_count": 2
}
```

### Get Transaction
```
GET /api/v2/minikit/transaction/{transaction_id}

Headers:
  Authorization: Bearer {API_KEY}

Response:
{
  "transaction_id": "...",
  "status": "confirmed",
  "hash": "0x...",
  "block_number": 123456
}
```

### Get Transaction Debug URL
```
GET /api/v2/minikit/transaction/debug?transaction_id={id}

Headers:
  Authorization: Bearer {API_KEY}

Response:
{
  "tenderly_url": "https://dashboard.tenderly.co/..."
}
```

### Get User Grant Cycle
```
GET /api/v2/minikit/user-grant-cycle

Headers:
  Authorization: Bearer {API_KEY}

Response:
{
  "next_grant_date": "2026-02-15T00:00:00Z",
  "grant_type": "humanity"
}
```

## Public APIs

### Get Token Prices
```
GET /public/v1/miniapps/prices

Response:
{
  "WLD": {
    "USD": 2.50,
    "EUR": 2.30,
    "KRW": 3300
  },
  "USDC": {
    "USD": 1.00,
    "EUR": 0.92,
    "KRW": 1320
  }
}
```

## Rate Limits

| Endpoint | Limit |
|----------|-------|
| Notifications (unverified) | 40 per 4 hours |
| Notifications (verified) | Higher limits |
| Transactions | 500 per user per day |
| Verification | No limit |

## Error Responses

```json
{
  "error": {
    "code": "invalid_proof",
    "message": "The provided proof is invalid"
  }
}
```

| Code | Description |
|------|-------------|
| `invalid_proof` | Proof verification failed |
| `already_verified` | User already verified for this action |
| `rate_limited` | Too many requests |
| `unauthorized` | Invalid or missing API key |
| `invalid_request` | Malformed request body |
