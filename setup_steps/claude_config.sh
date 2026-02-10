#!/bin/bash
# Claude Code configuration setup

echo "Setting up Claude Code configuration..."

CLAUDE_CONFIG_REPO="$HOME/scottleeroberts/claude-config"
CLAUDE_DIR="$HOME/.claude"

# Install Claude Code if not already installed
if ! command -v claude &> /dev/null; then
  echo "Installing Claude Code CLI..."
  curl -fsSL https://raw.githubusercontent.com/anthropics/claude-code/main/install.sh | bash

  # Add to PATH if not already there
  if ! grep -q '.local/bin' ~/.zshrc 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
  fi
else
  echo "Claude Code already installed"
fi

# Clone claude-config repository
if [ ! -d "$CLAUDE_CONFIG_REPO" ]; then
  echo "Cloning claude-config repository..."
  mkdir -p "$(dirname "$CLAUDE_CONFIG_REPO")"
  git clone git@github.com:scottleeroberts/claude-config.git "$CLAUDE_CONFIG_REPO"
else
  echo "claude-config repository already exists"
fi

# Backup existing .claude directory if it exists
if [ -d "$CLAUDE_DIR" ] && [ ! -L "$CLAUDE_DIR/CLAUDE.md" ]; then
  echo "Backing up existing Claude configuration..."
  mv "$CLAUDE_DIR" "${CLAUDE_DIR}.backup"
  echo "Backup created at ${CLAUDE_DIR}.backup"
fi

# Stow Claude configuration
echo "Deploying Claude configuration with stow..."
cd "$CLAUDE_CONFIG_REPO"
stow -v .claude

# Restore credentials if backed up
if [ -f "${CLAUDE_DIR}.backup/.credentials.json" ]; then
  echo "Restoring credentials from backup..."
  cp "${CLAUDE_DIR}.backup/.credentials.json" "$CLAUDE_DIR/"
fi

echo "Claude configuration deployed successfully"
echo ""
echo "Next steps for Claude Code:"
echo "1. Add API credentials to ~/.claude/.credentials.json"
echo "2. Configure Linear integration if needed"
echo "3. Run 'claude' to verify installation"
echo ""
echo "To install Claude plugins:"
echo "  /plugin marketplace add https://github.com/EveryInc/compound-engineering-plugin"
echo "  /plugin marketplace add thedotmack/claude-mem"
echo "  /plugin install compound-engineering"
echo "  /plugin install claude-mem"
