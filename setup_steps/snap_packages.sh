#!/bin/bash
# Snap package installation

echo "Installing Snap packages..."

# Ensure snapd is installed
sudo apt install -y snapd

# Check if systemd is available (required for snap)
if systemctl is-system-running &>/dev/null || systemctl status &>/dev/null 2>&1; then
  echo "systemd detected - enabling snapd service"
  sudo systemctl enable --now snapd.socket 2>/dev/null || true

  # Wait a moment for snapd to initialize
  sleep 2

  # Install packages
  if sudo snap install alacritty --classic 2>/dev/null; then
    echo "Snap packages installed successfully"
  else
    echo "Warning: Snap installation failed - this may require a system reboot"
    echo "After reboot, run: sudo snap install alacritty --classic"
  fi
else
  echo "Warning: systemd not detected (Docker environment?)"
  echo "Skipping snap package installation - snap requires systemd"
  echo ""
  echo "On a real Ubuntu system, snap will work automatically."
  echo "For Docker, consider installing Alacritty via cargo or building from source."
fi

echo "Snap setup complete"
