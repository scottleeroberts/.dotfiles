#!/bin/bash
# Ubuntu i3 Installation Script
# Last updated: 2026-02-10
# Target: Fresh Ubuntu installation

# Exit on error, but allow individual steps to handle their own errors
set -e

# Detect if running in Docker
if [ -f /.dockerenv ]; then
  echo "⚠️  Docker environment detected"
  echo "Some features (snap, systemd services) may be skipped"
  echo ""
  export DOCKER_ENV=true
fi

echo "========================================"
echo "  Ubuntu i3 Dotfiles Installation"
echo "========================================"
echo ""

# Create directory structure
echo "Creating directory structure..."
mkdir -p ~/opt ~/src ~/.local/share ~/.local/bin

# Backup existing configs (if they exist)
echo "Backing up existing configurations..."
for file in ~/.Xresources ~/.gtkrc-2.0; do
  [ -f "$file" ] && mv "$file" "$file.original" && echo "  Backed up $file"
done
for dir in ~/.config/gtk-3.0 ~/.config/dunst ~/.config/picom.conf; do
  [ -e "$dir" ] && mv "$dir" "$dir.original" && echo "  Backed up $dir"
done

# Update system
echo ""
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install base dependencies
echo ""
echo "Installing base dependencies..."
sudo apt install -y git curl build-essential stow

# Execute installation steps
echo ""
echo "========================================"
echo "  Installing System Components"
echo "========================================"
echo ""

source ~/.dotfiles/setup_steps/apt_packages.sh || echo "Warning: APT packages step had issues"
echo ""

source ~/.dotfiles/setup_steps/homebrew.sh || echo "Warning: Homebrew step had issues"
echo ""

source ~/.dotfiles/setup_steps/snap_packages.sh || echo "Warning: Snap packages step had issues"
echo ""

source ~/.dotfiles/setup_steps/version_managers.sh || echo "Warning: Version managers step had issues"
echo ""

source ~/.dotfiles/setup_steps/docker_setup.sh || echo "Warning: Docker setup step had issues"
echo ""

source ~/.dotfiles/setup_steps/shell.sh || echo "Warning: Shell setup step had issues"
echo ""

source ~/.dotfiles/setup_steps/ruby.sh || echo "Warning: Ruby setup step had issues"
echo ""

source ~/.dotfiles/setup_steps/claude_config.sh || echo "Warning: Claude config step had issues"
echo ""

# Stow dotfiles
echo "========================================"
echo "  Deploying Dotfiles"
echo "========================================"
echo ""
source ~/.dotfiles/stow_all

# Optional components (commented by default)
# source ~/.dotfiles/setup_steps/gtk.sh

echo ""
echo "========================================"
echo "  Installation Complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "1. Log out and log back in for group changes to take effect"
echo "2. Run 'chsh -s /usr/bin/zsh' if shell wasn't changed"
echo "3. Start a new terminal to load ZSH configuration"
echo "4. Configure Claude Code: add Linear API key to ~/.claude/.credentials.json"
echo ""
echo "To verify installation:"
echo "  ruby --version    # Should show latest 3.x"
echo "  nvim --version    # Should show latest stable"
echo "  node --version    # Should show latest v24.x LTS"
echo "  docker ps         # Should work without sudo"
echo "  claude --version  # Verify Claude Code"
echo ""
