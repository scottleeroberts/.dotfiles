opentmux() {
  if [ -z "$TMUX" ]; then
    tmux ls
    echo ""
    echo "Enter a session number, press w for work, q to not launch tmux, or n for a new session"
    read -p "response?[#/N/q] " response
    case $response in
      [qQ])
        return 1
        ;;
      [wW])
        sh ~/tmux.sh
        ;;
      *)
        tmux attach -t $response || tmux new
        ;;
    esac
  fi
}
