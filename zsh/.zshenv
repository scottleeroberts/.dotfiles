export DOTFILES=$HOME/.dotfiles

export EDITOR=nvim
export BROWSER="firefox"

export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:~/bin:~/scripts:/opt/local/sbin:$PATH"
export PATH="$DOTFILES/bin:$PATH"

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_COMPLETION_TRIGGER=',,'
export RSPEC_CORES=8
export FILTHY_SHOW_EXIT_CODE=1

export NODE_OPTIONS="--max-old-space-size=16384"

[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local
