# nvim bubblewrap sandbox

Wraps `nvim` in [bubblewrap](https://github.com/containers/bubblewrap) so a
compromised neovim plugin cannot read host credentials. Lightweight alternative
to running nvim inside a Docker container: ~70 lines, no image, no daemon,
host nvim and toolchains used directly.

## Install

```
sudo pacman -S bubblewrap
cd ~/.dotfiles && stow bin
```

Make sure `~/bin` precedes `/usr/bin` in `$PATH` so the wrapper shadows the
real nvim binary.

## Threat model

**Defends against:** a malicious or supply-chain-compromised plugin running
arbitrary code as the user during normal nvim usage. Targets the read step —
the plugin cannot exfiltrate what it cannot see.

**Blocked (invisible inside the sandbox):**

- `~/.ssh` — SSH private keys
- `~/.gnupg` — GPG keys
- `~/.aws`, `~/.kube`, `~/.docker` — cloud credentials
- `~/.config/*` (except `nvim` and `github-copilot`)
- Browser profiles, password stores, keyring data
- Shell history, `~/.netrc`, arbitrary dotfiles
- Other users' home directories, `/root`, `/var`, `/srv`

**Allowed (bound back in):**

- `$PWD` — the project being edited (read-write)
- `~/.config/nvim` — nvim config (read-only)
- `~/.local/share/nvim`, `~/.local/state/nvim`, `~/.cache/nvim` — plugin data
- `~/.gitconfig` — read-only
- `~/.claude`, `~/.claude.json`, `~/.config/github-copilot` — read-only
- `~/go`, `~/.cache/go-build`, `~/.rubies`, `~/.gem` — toolchain caches
- `/usr`, `/etc`, `/opt` — read-only system binaries and config
- tmux socket directory — for vim-tmux-navigator and `run_in_split`

**Disabled env:** `SSH_AUTH_SOCK`, `GPG_AGENT_INFO`, `GNUPGHOME`,
`DBUS_SESSION_BUS_ADDRESS` — so a plugin can't ride the agent or talk to
session services even if a stray socket leaks through.

## Residual risks (be honest)

1. **Network is fully open** (`--share-net`, matching the Docker PR). Copilot,
   Mason, LSP installs, and plugin updates need it. A plugin can still POST
   data anywhere — it just has nothing sensitive to send.

2. **Mounted tokens are still mounted.** `~/.claude*` and the Copilot config
   are bound read-only so plugins can't corrupt them, but a plugin can read
   the token bytes and exfiltrate over the network. If you don't want this,
   delete those bind lines from `bin/nvim`; Copilot and the Claude integration
   will stop working inside the sandbox.

3. **Kernel attack surface.** bwrap uses Linux user namespaces; a kernel LPE
   in namespaced syscalls escapes the sandbox. Same risk as Docker on Linux.

4. **Project files themselves can be sensitive.** If your repo contains
   `.env` files with secrets, plugins read them — that's true outside any
   sandbox too. Keep secrets out of the repo.

## Extending

Need a path inside the sandbox? Add a line to `bin/nvim`:

```
  --bind-try "$HOME/.rustup" "$HOME/.rustup" \
```

Use `--ro-bind-try` for read-only, `--bind-try` for read-write. The `-try`
suffix means missing paths are skipped instead of erroring.

## Bypassing for one invocation

```
/usr/bin/nvim file.txt        # absolute path skips the wrapper
NVIM_SANDBOX=0 nvim file.txt  # informational only; wrapper still runs
```

Inside the sandbox `$NVIM_SANDBOX=1` is set, so nvim config can branch on it
if needed (currently nothing does — config behaves identically in and out).
