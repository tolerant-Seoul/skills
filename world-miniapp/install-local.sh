#!/bin/bash
# Local installation script - run from the skill directory
# Usage: ./install-local.sh

set -e

SKILL_NAME="world-miniapp"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$HOME/.claude/skills/$SKILL_NAME"

echo "Installing $SKILL_NAME from local files..."

# Backup existing
if [ -d "$TARGET_DIR" ]; then
    BACKUP_DIR="$TARGET_DIR.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Backing up existing skill to $BACKUP_DIR"
    mv "$TARGET_DIR" "$BACKUP_DIR"
fi

# Create directory and copy files
mkdir -p "$TARGET_DIR/references"
cp "$SCRIPT_DIR/SKILL.md" "$TARGET_DIR/"
cp "$SCRIPT_DIR/references/"*.md "$TARGET_DIR/references/"

echo "✓ Installed to $TARGET_DIR"
echo ""
echo "Usage: Type /world in Claude Code to activate"
