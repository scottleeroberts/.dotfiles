fzf_prog(){
  if [ "$TMUX" == "" ] || [ "$TMUX" =~ "tmate" ]; then
    echo "fzf"
  else
    echo "fzf-tmux"
  fi
}
