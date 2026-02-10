FROM ubuntu:24.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Create test user with sudo privileges
RUN useradd -m -s /bin/bash testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to test user
USER testuser
WORKDIR /home/testuser

# Copy dotfiles
COPY --chown=testuser:testuser . /home/testuser/.dotfiles

# Set up git (required for some installations)
RUN git config --global user.name "Test User" && \
    git config --global user.email "test@example.com"

# Run setup script (allow continuation even with errors)
RUN cd /home/testuser/.dotfiles && bash setup-ubuntu.sh || echo "Setup completed with some warnings"

# Verify installations
RUN echo "=== Installation Verification ===" && \
    echo "Git: $(git --version 2>/dev/null || echo 'NOT INSTALLED')" && \
    echo "i3: $(i3 --version 2>&1 | head -n1 || echo 'NOT INSTALLED')" && \
    echo "Homebrew: $(/home/linuxbrew/.linuxbrew/bin/brew --version 2>/dev/null | head -n1 || echo 'NOT INSTALLED')" && \
    echo "Node: $(node --version 2>/dev/null || echo 'NOT INSTALLED')" && \
    echo "Ruby: $(ruby --version 2>/dev/null || echo 'NOT INSTALLED')" && \
    echo "Neovim: $(nvim --version 2>/dev/null | head -n1 || echo 'NOT INSTALLED')"

CMD ["/bin/bash"]
