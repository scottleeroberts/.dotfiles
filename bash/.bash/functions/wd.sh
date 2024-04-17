# vi: set ft=bash :

WD_DIRS_LOCATION=~/.dirs

function wd() {
  if [[ $# -eq 0 ]]; then
    if [ -f "$WD_DIRS_LOCATION" ]; then
      files=$(sed 's/#.*//g; /^\s*$/d' "$WD_DIRS_LOCATION" | sort -u)
      if [ -z "$TMUX" ] || [[ "$TMUX" =~ "tmate" ]]; then
        destination=$(echo "$files" | fzf | sed 's/^.*: //')
      else
        destination=$(echo "$files" | fzf-tmux | sed 's/^.*: //')
      fi

      if [[ -n $destination ]]; then
        cd "$destination" || return
      fi
    else
      touch "$WD_DIRS_LOCATION"
      echo "Created $WD_DIRS_LOCATION"
    fi
  fi
}

function wda() {
  echo "$@: $(pwd)" >> "$WD_DIRS_LOCATION"
}
