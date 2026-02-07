#!/bin/bash
# World Mini App Skill Installer for Claude Code
# Usage: curl -fsSL https://raw.githubusercontent.com/tolerant-Seoul/skills/main/world-miniapp/install.sh | bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SKILL_NAME="world-miniapp"
CLAUDE_DIR="$HOME/.claude"
SKILLS_DIR="$CLAUDE_DIR/skills"
TARGET_DIR="$SKILLS_DIR/$SKILL_NAME"

# GitHub raw content base URL (update with your repo)
GITHUB_RAW_BASE="${GITHUB_RAW_BASE:-https://raw.githubusercontent.com/tolerant-Seoul/skills/main/world-miniapp}"

echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  World Mini App Skill Installer            ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
echo ""

# Check if Claude directory exists
if [ ! -d "$CLAUDE_DIR" ]; then
    echo -e "${RED}Error: Claude directory not found at $CLAUDE_DIR${NC}"
    echo "Please install Claude Code first: https://claude.ai/code"
    exit 1
fi

# Create skills directory if it doesn't exist
if [ ! -d "$SKILLS_DIR" ]; then
    echo -e "${YELLOW}Creating skills directory...${NC}"
    mkdir -p "$SKILLS_DIR"
fi

# Backup existing skill if present
if [ -d "$TARGET_DIR" ]; then
    BACKUP_DIR="$TARGET_DIR.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "${YELLOW}Backing up existing skill to $BACKUP_DIR${NC}"
    mv "$TARGET_DIR" "$BACKUP_DIR"
fi

# Create target directory
echo -e "${GREEN}Installing $SKILL_NAME skill...${NC}"
mkdir -p "$TARGET_DIR/references"

# Download files
echo "Downloading SKILL.md..."
curl -fsSL "$GITHUB_RAW_BASE/SKILL.md" -o "$TARGET_DIR/SKILL.md"

echo "Downloading references..."
curl -fsSL "$GITHUB_RAW_BASE/references/api-endpoints.md" -o "$TARGET_DIR/references/api-endpoints.md"
curl -fsSL "$GITHUB_RAW_BASE/references/backend-verification.md" -o "$TARGET_DIR/references/backend-verification.md"
curl -fsSL "$GITHUB_RAW_BASE/references/deep-links.md" -o "$TARGET_DIR/references/deep-links.md"
curl -fsSL "$GITHUB_RAW_BASE/references/minikit-commands.md" -o "$TARGET_DIR/references/minikit-commands.md"

echo ""
echo -e "${GREEN}✓ Installation complete!${NC}"
echo ""
echo "Installed to: $TARGET_DIR"
echo ""
echo "Files installed:"
find "$TARGET_DIR" -type f -name "*.md" | while read file; do
    echo "  - ${file#$TARGET_DIR/}"
done
echo ""
echo -e "${GREEN}Usage:${NC} Type ${YELLOW}/world${NC} in Claude Code to activate the skill"
echo ""
