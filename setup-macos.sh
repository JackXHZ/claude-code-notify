#!/bin/bash
# Automated setup for Claude Code Notify (macOS)

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"

echo "Setting up Claude Code Notify for macOS..."

# Create directories if they don't exist
mkdir -p "$COMMANDS_DIR"

# Copy files
cp "$SCRIPT_DIR/macos/notify.sh" "$CLAUDE_DIR/notify.sh"
cp "$SCRIPT_DIR/macos/settings.json" "$CLAUDE_DIR/settings.json"
cp "$SCRIPT_DIR/macos/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
cp "$SCRIPT_DIR/macos/commands/notify.md" "$COMMANDS_DIR/notify.md"

# Make notification script executable
chmod +x "$CLAUDE_DIR/notify.sh"

echo ""
echo "Setup complete! Files installed to $CLAUDE_DIR/"
echo ""
echo "Next step: Open Claude Code and run /hooks to verify the hook is registered."
