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


source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.fzf/shell/key-bindings.zsh
source ~/.fzf/shell/completion.zsh

[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.zshrc.local ]] &&  source ~/.zshrc.local

if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
source /home/linuxbrew/.linuxbrew/opt/chruby/share/chruby/chruby.sh
chruby ruby-3.4.1 2>/dev/null || chruby ruby-3.4.4 2>/dev/null

opentmux

# export PATH="$(ruby -r rubygems -e 'print Gem.bindir'):$PATH"
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

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
alias claude-mem='/home/scott.roberts/.bun/bin/bun "/home/scott.roberts/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=~/.npm-global/bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
