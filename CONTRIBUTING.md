# Contributing to Claude Code Skills

Thank you for your interest in contributing! This document guides you through the contribution process.

## How to Contribute

### Bug Reports

1. Check [Issues](https://github.com/tolerant-Seoul/skills/issues) for existing reports
2. When creating a new issue, include:
   - Skill name
   - Steps to reproduce
   - Expected vs actual behavior
   - Claude Code version

### Proposing New Skills

1. Share your idea in [Discussions](https://github.com/tolerant-Seoul/skills/discussions)
2. Gather community feedback
3. Proceed with development after approval

### Pull Requests

1. Fork and create a feature branch
   ```bash
   git checkout -b feat/new-skill-name
   ```

2. Commit your changes
   ```bash
   git commit -m "feat: add new-skill-name skill"
   ```

3. Push and create a PR
   ```bash
   git push origin feat/new-skill-name
   ```

## Skill Development Guide

### Required Files

```
skill-name/
├── SKILL.md          # Skill definition (required)
└── README.md         # Installation guide (recommended)
```

### SKILL.md Format

```yaml
---
name: skill-name
description: One-line description
---

# Skill Title

## Overview
Brief overview of the skill

## Key Features
- Feature 1
- Feature 2

## Usage Examples
Code examples...
```

### Quality Checklist

- [ ] No hardcoded paths (portability)
- [ ] Code examples are runnable
- [ ] Clear explanations and documentation
- [ ] install.sh tested
- [ ] Installation tested on different OS

## Commit Message Convention

```
feat: Add new feature
fix: Bug fix
docs: Documentation update
refactor: Code refactoring
```

## Code Review

All PRs are reviewed before merging:
- Skill structure verification
- Portability check
- Documentation completeness

## Questions

For questions, please use [Discussions](https://github.com/tolerant-Seoul/skills/discussions).
