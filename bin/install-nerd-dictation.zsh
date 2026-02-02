#!/usr/bin/env zsh
# nerd-dictation installation script
# Installs nerd-dictation with VOSK large model for offline speech-to-text

set -e

INSTALL_DIR="${HOME}/.local/share/nerd-dictation"
MODEL_URL="https://alphacephei.com/vosk/models/vosk-model-en-us-0.22.zip"

echo "=== nerd-dictation Installation ==="
echo ""

# Check for required system packages
echo "Checking system dependencies..."
MISSING_DEPS=()

if ! command -v git &> /dev/null; then
    MISSING_DEPS+=(git)
fi

if ! command -v python3 &> /dev/null; then
    MISSING_DEPS+=(python3)
fi

if ! command -v wget &> /dev/null; then
    MISSING_DEPS+=(wget)
fi

if ! command -v unzip &> /dev/null; then
    MISSING_DEPS+=(unzip)
fi

if ! command -v xdotool &> /dev/null; then
    MISSING_DEPS+=(xdotool)
fi

if [[ ${#MISSING_DEPS[@]} -gt 0 ]]; then
    echo "Missing dependencies: ${MISSING_DEPS[@]}"
    echo "Install with: sudo apt-get install ${MISSING_DEPS[@]}"
    exit 1
fi

echo "✓ All dependencies found"
echo ""

# Create install directory
mkdir -p "${INSTALL_DIR}"
cd "${INSTALL_DIR}"

# Clone nerd-dictation
if [[ -d "nerd-dictation" ]]; then
    echo "nerd-dictation already exists, skipping clone"
else
    echo "Cloning nerd-dictation..."
    git clone https://github.com/ideasman42/nerd-dictation.git
fi
cd nerd-dictation

# Setup Python venv
echo "Setting up Python virtual environment..."
python3 -m venv .venv
source .venv/bin/activate
pip install --quiet --upgrade pip
pip install --quiet vosk

# Download and extract VOSK model
if [[ -d "model" ]]; then
    echo "VOSK model already exists"
else
    echo "Downloading VOSK large model (1.8GB, ~5 minutes)..."
    wget "${MODEL_URL}" -O model.zip
    echo "Extracting model..."
    unzip -q model.zip
    mv vosk-model-en-us-0.22 model
    rm model.zip
fi

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Installed at: ${INSTALL_DIR}/nerd-dictation"
echo "Model: Large English (1.8GB, ~94% accuracy)"
echo ""
echo "Next steps:"
echo "1. Wrapper scripts should already be in ~/.dotfiles/bin/"
echo "2. i3 keybinding: Mod+y (toggle recording)"
echo "3. i3blocks indicator shows 'MIC' (green) when recording"
echo ""
