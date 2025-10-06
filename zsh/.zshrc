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
bindkey jj vi-cmd-mode
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
# bindkey "^R" history-incremental-search-backward
bindkey "^v" edit-command-line

fpath=(~/.zsh/filthy $fpath)

autoload -U promptinit && promptinit
autoload -Uz compinit && compinit

prompt filthy


source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.fzf/shell/key-bindings.zsh
source ~/.fzf/shell/completion.zsh

[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.zshrc.local ]] &&  source ~/.zshrc.local

opentmux

# — Homebrew (Linuxbrew) setup —
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
source "$(brew --prefix)/opt/chruby/share/chruby/chruby.sh"
source "$(brew --prefix)/opt/chruby/share/chruby/auto.sh"
# export PATH="$(ruby -r rubygems -e 'print Gem.bindir'):$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

export PATH=~/.npm-global/bin:$PATH
