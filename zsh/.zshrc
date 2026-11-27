unsetopt nomatch
setopt extendedglob
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history
setopt inc_append_history
setopt extended_history

#load custom functions
for function in ~/.zsh/functions/*; do
  source $function
done

autoload -z edit-command-line
zle -N edit-command-line
bindkey -v

# Ensure we always start in insert mode
function zle-line-init {
    zle -K viins
}
zle -N zle-line-init

bindkey jj vi-cmd-mode
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
# bindkey "^R" history-incremental-search-backward
bindkey "^v" edit-command-line

fpath=(~/.zsh/filthy $fpath)

autoload -U promptinit && promptinit
autoload -Uz compinit && compinit

prompt filthy


for highlighting_script in \
  /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
  if [[ -r "$highlighting_script" ]]; then
    source "$highlighting_script"
    break
  fi
done
unset highlighting_script

source ~/.fzf/shell/key-bindings.zsh
source ~/.fzf/shell/completion.zsh

[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.zshrc.local ]] &&  source ~/.zshrc.local

if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Discard Ruby state inherited from the retired version manager, including tmux.
unset GEM_HOME GEM_PATH GEM_ROOT RUBY_ENGINE RUBY_ROOT RUBY_VERSION RUBYLIB RUBYOPT
path=(${path:#$HOME/.gem/ruby/*})
path=(${path:#$HOME/.rubies/*})

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

opentmux

export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH=~/.npm-global/bin:$PATH

# Load secrets (tokens, API keys) from non-tracked file
if [ -f ~/.secrets ]; then
    source ~/.secrets
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

if [[ -r "$HOME/.local/bin/env" ]]; then
  source "$HOME/.local/bin/env"
fi

alias claude-mem='/home/scott.roberts/.bun/bin/bun "/home/scott.roberts/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'
