function opentmux() {
  [[ -n "$TMUX" ]] && return 0

  if (( ! $+commands[fzf] )); then
    sh "$HOME/tmux.sh"
    return
  fi

  local selection
  selection=$(
    {
      printf '%s\n' work '+ new session'
      tmux list-sessions -F '#{session_name}' 2>/dev/null
    } |
      awk '!seen[$0]++' |
      fzf \
        --height=40% \
        --layout=reverse \
        --border \
        --prompt='tmux session> ' \
        --header='Enter: attach  Esc: stay in shell'
  ) || return 0

  case "$selection" in
    work)
      sh "$HOME/tmux.sh"
      ;;
    '+ new session')
      tmux new-session
      ;;
    *)
      tmux attach-session -t "=$selection"
      ;;
  esac
}
