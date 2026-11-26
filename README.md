# Dotfiles

The installer targets **Ubuntu 24.04 LTS** and **Arch Linux** after the base OS
is installed. Run it as your regular user from a checkout you plan to keep,
such as `~/.dotfiles`. The account needs `sudo`, and the installer needs
network access to the OS package repositories and upstream downloads.

```bash
git clone git@github.com:scottleeroberts/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup/install.sh                     # Terminal and editor
# OR
./setup/install.sh --desktop           # Also install and link the X11/i3 desktop
```

The previous `setup-ubuntu.sh` and `setup-arch.sh` entry points both call
the shared installer. Ubuntu uses APT and checksum-pinned upstream builds of
Neovim 0.12.4, Tree-sitter CLI 0.26.9, fzf 0.75.0, and Node.js 24.22.3 in
`~/.local/opt` on x86-64 or ARM64. Arch uses native packages and runs a full
`pacman -Syu` to keep the package database and installed packages in sync.
The desktop option installs the Lilex Nerd Font Mono used by Alacritty.

GNU Stow links the configuration from the checkout. If it reports a conflict,
review and move or merge the conflicting file yourself before rerunning.
`./stow_all --check` shows conflicts for all modules and
`./stow_all --core --check` checks only the terminal and editor modules.
Keep the checkout in place after running Stow. Use a separate checkout and
`tests/container.sh` when evaluating changes to an existing installation.

Neovim checks out plugins at the versions in `lazy-lock.json`, builds the
native Telescope extension, and waits for the configured Tree-sitter parsers.
Use `--no-plugins` to defer plugin setup. Run `./setup/neovim.sh install` later
with `~/.local/bin` on PATH. Set the login shell yourself if desired.

```bash
chsh -s "$(command -v zsh)"
```

Set `DOTFILES_NO_AUTOTMUX=1` in `~/.zshenv.local` to disable the tmux prompt.
Set up credentials, project-specific language servers, version managers,
browser applications, and Docker separately. The older `setup_steps/`
scripts and `TEST_RESULTS*.md` document the previous installer.

## Validation

```bash
./tests/verify.sh              # Check the installed core setup
./tests/verify.sh --desktop    # Also check desktop commands, i3 config, and font
./tests/container.sh all       # Fresh Ubuntu 24.04 and Arch containers
```

The container suite tests a Stow conflict and checks that the original file
survives. It then installs the desktop profile twice as a regular user and
verifies links, interactive Zsh widgets, tmux options and pane splits, Neovim
plugin pins and native extension loading, Tree-sitter parser installation and
Ruby highlighting, i3 config parsing, and the configured font. GitHub Actions
runs the same commands for both distributions.

For the desktop itself, boot a VM or log in to an X11 session on the target
machine. Review the monitor outputs, display modes, keybindings, and app
autostart commands in `i3/.config/i3/config`. Verify i3 login, Alacritty,
compositing, audio, and display behavior there.
