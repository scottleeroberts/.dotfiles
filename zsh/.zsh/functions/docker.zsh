alias d="docker"
alias dc="docker compose"
alias dcup="docker compose up"
alias dcdn="docker compose down"
alias dcq="docker compose run web bundle exec rake resque:work QUEUE=*"
alias dcdus="docker compose down; RESEED=true docker compose up"
alias dcdu="docker compose down; docker compose up"
alias cnuke="docker container prune -f; docker volume prune -f; docker image prune -f"

dr_db() {
  containers=$(docker ps -a --format "{{.ID}} {{.Names}} {{.Image}}" | grep unsafe_postgres)
  target=$(echo $containers | fzf | awk '{ print $1 }')
  echo $containers | awk '{ print $1 }' | xargs -I NAME docker stop NAME > /dev/null
  docker start $target > /dev/null
}

dr_stop(){
  containers=$(docker ps --format "{{.ID}} {{.Names}} {{.Image}}" )
  target=$(echo $containers | fzf | awk '{ print $1 }')
  docker stop $target > /dev/null
}


