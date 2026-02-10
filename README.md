# dotfiles

## Setup for Ubuntu

These instructions are for a fresh Ubuntu installation (tested on Ubuntu 24.04+).

### Prerequisites

1. Install Ubuntu (minimal or full installation)
2. Update system: `sudo apt update && sudo apt upgrade -y`
3. Install Git: `sudo apt install -y git`
4. Add your SSH key to GitHub for cloning repositories

### Installation

```bash
# Clone dotfiles
git clone git@github.com:scottleeroberts/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run setup script
bash setup-ubuntu.sh
```

The script will:
- Install system packages via APT (i3, rofi, dunst, fonts, etc.)
- Install Homebrew and development tools (gh, tig, fzf, btop, etc.)
- Set up version managers (bob for Neovim, chruby for Ruby)
- Configure Docker
- Deploy dotfiles via GNU Stow
- Clone and deploy Claude Code configuration
- Set ZSH as default shell

### Post-Installation

1. **Log out and log back in** for group changes (Docker) to take effect
2. Start a new terminal to load ZSH configuration
3. Configure Claude Code:
   ```bash
   # Add API credentials
   vim ~/.claude/.credentials.json

   # Install plugins
   /plugin marketplace add https://github.com/EveryInc/compound-engineering-plugin
   /plugin marketplace add thedotmack/claude-mem
   /plugin install compound-engineering
   /plugin install claude-mem
   ```
4. Verify installations:
   ```bash
   ruby --version    # Should show 3.4.x
   nvim --version    # Should show 0.11.6
   node --version    # Should show v24.13.0
   docker --version  # Should work without sudo
   claude --version  # Verify Claude Code
   ```

### Validation Checklist

After running the setup script, verify:

- [ ] ZSH is the default shell: `echo $SHELL` → `/usr/bin/zsh`
- [ ] Homebrew is installed: `brew --version`
- [ ] Ruby 3.4.x via chruby: `ruby --version`
- [ ] Neovim 0.11.6 via bob: `nvim --version`
- [ ] Node v24.x: `node --version`
- [ ] Python 3.13.x: `python3 --version`
- [ ] Docker without sudo: `docker ps` (no permission error)
- [ ] GitHub CLI: `gh --version`
- [ ] Alacritty: `alacritty --version`
- [ ] i3 is running: `i3 --version`
- [ ] Dotfiles are stowed: `ls -la ~/ | grep "^l"` (check for symlinks)
- [ ] Claude Code: `claude --version`
- [ ] Claude config: `ls -la ~/.claude/skills`
- [ ] Git configuration: `git config --global user.name`

### Optional Components

#### GTK Theme
To install the Numix Solarized GTK theme:
```bash
source ~/.dotfiles/setup_steps/gtk.sh
```

#### Nerd Fonts
For additional fonts with icon support, visit https://www.nerdfonts.com/ and install manually.

### Notes

- **USB WiFi Adapter (rtl88x2bu)**: Install `rtl88x2bu-dkms-git` if using USB WiFi on Arch-based systems
- **Archived Packages**: See comments in `setup_steps/apt_packages.sh` for packages not installed by default (mosh, ncdu, weechat, etc.)

## Legacy Setup (Arch-based)

For Manjaro/Arch installations, see `setup-arch.sh` (formerly `setup`).

These instructions are for a fresh Manjaro i3 edition install.

Before running the below commands make sure you can clone from GitHub by adding your SSH key to your profile.

```bash
git clone git@github.com:scottleeroberts/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash setup-arch.sh
```

Note: rtl88x2bu-dkms-git needed for USB WiFi adapter in Arch.
