# Versioning Strategy

## Philosophy: Latest Stable

This installation uses a **"latest stable"** approach to keep your system current without manual version tracking.

## Version Management by Category

### 📦 System Packages (APT)
**Strategy:** Latest from Ubuntu repositories
**Managed by:** APT package manager
**Updates:** `sudo apt update && sudo apt upgrade`

**Packages:**
- i3, rofi, dunst, picom (window manager ecosystem)
- Git, curl, wget, stow (utilities)
- Fonts, development tools

**Why:** Ubuntu repositories provide stable, tested versions. Security updates handled automatically.

---

### 🍺 Homebrew Packages
**Strategy:** Latest stable versions
**Managed by:** Homebrew
**Updates:** `brew update && brew upgrade`

**Packages:**
- gh, tig, fzf, ripgrep, fd, btop, htop
- lazydocker, docker-compose
- go, python@3.13
- xclip, speedtest-cli

**Why:** Homebrew ensures compatibility between packages. Always installs latest stable.

---

### 📸 Snap Packages
**Strategy:** Latest from Snap Store
**Managed by:** snapd
**Updates:** Automatic

**Packages:**
- Alacritty (terminal emulator)

**Why:** Snap handles updates automatically with rollback capability.

---

### 💎 Ruby
**Strategy:** Latest 3.x
**Current:** Installs newest Ruby 3.x.x
**Managed by:** ruby-install + chruby
**Updates:** Re-run `ruby-install ruby-3`

**Why:**
- Major version (3.x) provides stability
- Minor/patch versions (3.x.x) provide features and security
- No specific patch version needed

**Upgrade:**
```bash
ruby-install ruby-3  # Installs latest 3.x
chruby 3.x.x         # Switch to new version
```

---

### 🟢 Node.js
**Strategy:** Latest v24.x LTS
**Current:** v24.13.0 (automatically gets latest v24.x)
**Managed by:** NodeSource repository
**Updates:** `sudo apt update && sudo apt upgrade nodejs`

**Why:**
- v24 is LTS (Long Term Support)
- Gets security updates within major version
- Stable for production use

**Note:** Major version pinned to v24 to avoid breaking changes. When v26 LTS releases, manually update setup script.

---

### 📝 Neovim
**Strategy:** Latest stable
**Current:** Automatically installs latest stable
**Managed by:** bob (Neovim version manager)
**Updates:** `bob update && bob use stable`

**Why:**
- "stable" channel provides tested releases
- bob handles binary downloads and PATH management
- Easy rollback if issues occur

**Upgrade:**
```bash
bob update    # Check for new versions
bob use stable  # Switch to latest stable
```

---

### 🐍 Python
**Strategy:** Latest 3.13.x
**Managed by:** Homebrew
**Updates:** `brew upgrade python@3.13`

**Why:**
- Minor version (3.13) pinned for compatibility
- Gets patch updates automatically
- When 3.14 releases, explicitly update to `python@3.14`

---

### 🐳 Docker
**Strategy:** Latest from Docker CE repository
**Managed by:** APT (Docker's repository)
**Updates:** `sudo apt update && sudo apt upgrade docker-ce`

**Why:** Docker CE repository provides latest stable releases with security updates.

---

## Update Workflow

### Daily Use
All packages update automatically or via system updates:
```bash
sudo apt update && sudo apt upgrade  # Ubuntu + Node + Docker
brew update && brew upgrade           # Homebrew packages
```

### Manual Updates
When you want the absolute latest:
```bash
# Ruby
ruby-install ruby-3
chruby <new-version>

# Neovim
bob update
bob use stable

# Verify
ruby --version
nvim --version
node --version
```

---

## When to Pin Specific Versions

Only pin specific versions when:
1. **Known Bug:** Specific version has a critical bug
2. **Breaking Change:** New version breaks your setup
3. **Production Match:** Need exact version as production

### How to Pin a Version

If needed, edit the setup scripts:

**Ruby:**
```bash
# setup_steps/ruby.sh
install_ruby "3.4.2"  # Specific version
```

**Neovim:**
```bash
# setup_steps/version_managers.sh
bob install 0.11.6
bob use 0.11.6
```

**Node.js:**
```bash
# setup_steps/version_managers.sh
curl -fsSL https://deb.nodesource.com/setup_22.x  # Change major version
```

---

## Benefits of This Approach

✅ **Always Current:** Get latest features and security fixes
✅ **Low Maintenance:** No manual version tracking
✅ **Stable:** Major versions pinned where it matters (Node LTS)
✅ **Flexible:** Easy to update or pin if needed
✅ **Reproducible:** Setup script installs predictable versions

---

## Summary

| Tool | Version Strategy | Update Method |
|------|------------------|---------------|
| APT packages | Latest stable | `apt upgrade` |
| Homebrew | Latest stable | `brew upgrade` |
| Snap | Latest | Automatic |
| Ruby | Latest 3.x | `ruby-install ruby-3` |
| Node.js | Latest v24.x LTS | `apt upgrade nodejs` |
| Neovim | Latest stable | `bob update` |
| Python | Latest 3.13.x | `brew upgrade python@3.13` |
| Docker | Latest stable | `apt upgrade docker-ce` |

**Philosophy:** Stay current by default, pin only when necessary.
