buildrelease() {
  if [[ $# > 0 ]]; then
    wf --approved-prs | fzf -m | cut -d' ' -f1 | tr '\n' ',' | xargs wf --build-release --list $1 --pull-requests
  else
    echo "argument required (release name)"
  fi
}

function finished() {
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  CARD=${${BRANCH[(ws:/:)2]}[(ws:-:)1]}

  wf --finish-card --card $CARD
}
