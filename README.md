# Claude Code Skills

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

A collection of community skills for [Claude Code](https://claude.ai/code).

## Available Skills

| Skill | Description | Install |
|-------|-------------|---------|
| [world-miniapp](./world-miniapp) | World Mini App development (World ID, MiniKit, World Chain) | [Install](#world-miniapp) |

---

## Quick Install

### world-miniapp

Development guide skill for World ID authentication, MiniKit SDK, and World Chain transactions.

```bash
curl -fsSL https://raw.githubusercontent.com/tolerant-Seoul/skills/main/world-miniapp/install.sh | bash
```

After installation, activate with `/world` command in Claude Code.

**Features:**
- MiniKit SDK setup and command reference
- World ID (Orb/Device) verification
- WLD/USDC payment processing
- Smart contract transactions
- Push notifications and deep links
- Backend verification patterns

---

## What are Claude Code Skills?

Skills are extensions that add domain-specific expertise to Claude Code. When installed, Claude leverages best practices, API references, and code patterns from that domain to provide more accurate responses.

**Installation directory:** `~/.claude/skills/`

---

## Contributing

Contributions are welcome! Whether it's adding new skills, fixing bugs, or improving documentation.

### Adding a New Skill

1. Fork this repository
2. Create a new skill directory: `your-skill-name/`
3. Add the required files:

```
your-skill-name/
├── SKILL.md              # Required: Skill definition (YAML frontmatter + content)
├── README.md             # Recommended: Installation and usage guide
├── install.sh            # Recommended: Remote installation script
└── references/           # Optional: Additional reference documents
    └── *.md
```

4. `SKILL.md` format:

```yaml
---
name: your-skill-name
description: Brief description of the skill
---

# Skill Title

Skill content...
```

5. Create a Pull Request

### Code Style

- Write Markdown files clearly and concisely
- Provide runnable code examples
- Avoid hardcoded paths (ensure portability)

### Pull Request Guidelines

- Write clear titles and descriptions
- Test the skill before submitting
- Link related issues if applicable

---

## Uninstall

To remove a skill:

```bash
rm -rf ~/.claude/skills/<skill-name>
```

---

## License

This project is licensed under the [Apache License 2.0](LICENSE).

---

## Support

- **Issues**: [GitHub Issues](https://github.com/tolerant-Seoul/skills/issues)
- **Discussions**: [GitHub Discussions](https://github.com/tolerant-Seoul/skills/discussions)

---

## Acknowledgments

- [Claude Code](https://claude.ai/code) by Anthropic
- Thanks to all contributors
