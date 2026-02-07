#!/bin/bash
# Uninstall World Mini App Skill
# Usage: ./uninstall.sh

set -e

SKILL_NAME="world-miniapp"
TARGET_DIR="$HOME/.claude/skills/$SKILL_NAME"

if [ -d "$TARGET_DIR" ]; then
    echo "Removing $SKILL_NAME skill..."
    rm -rf "$TARGET_DIR"
    echo "✓ Uninstalled successfully"
else
    echo "Skill not found at $TARGET_DIR"
fi
