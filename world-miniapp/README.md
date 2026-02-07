# World Mini App Skill for Claude Code

A Claude Code skill for World Mini App development, providing guides for World ID, MiniKit SDK, and World Chain integration.

## Installation

### Method 1: One-liner Install (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/tolerant-Seoul/skills/main/world-miniapp/install.sh | bash
```

### Method 2: Git Clone + Local Install

```bash
git clone https://github.com/tolerant-Seoul/skills.git
cd skills/world-miniapp
chmod +x install-local.sh
./install-local.sh
```

### Method 3: Manual Install

```bash
# Create skill directory
mkdir -p ~/.claude/skills/world-miniapp/references

# Copy files
cp SKILL.md ~/.claude/skills/world-miniapp/
cp references/*.md ~/.claude/skills/world-miniapp/references/
```

## Usage

Activate the skill in Claude Code with the `/world` command:

```
/world
```

The skill also activates automatically when you ask about World App, MiniKit, World ID, or World Chain.

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/tolerant-Seoul/skills/main/world-miniapp/uninstall.sh | bash
```

Or manually:

```bash
rm -rf ~/.claude/skills/world-miniapp
```

## Features

- **MiniKit SDK Integration**: Installation, setup, command reference
- **World ID Authentication**: Orb/Device verification, ZK proof handling
- **Payment System**: WLD/USDC payments, transaction verification
- **Smart Contracts**: World Chain transaction guide
- **Notifications & Deep Links**: Push notifications, app deep links
- **Backend Verification**: SIWE, proof verification, security patterns

## File Structure

```
~/.claude/skills/world-miniapp/
├── SKILL.md                         # Main skill definition
└── references/
    ├── api-endpoints.md             # API endpoint reference
    ├── backend-verification.md      # Backend verification patterns
    ├── deep-links.md                # Deep link guide
    └── minikit-commands.md          # MiniKit command quick reference
```

## License

MIT
