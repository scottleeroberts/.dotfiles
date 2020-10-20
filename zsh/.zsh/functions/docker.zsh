alias d="docker"
alias c="docker-compose"
alias drup="docker-compose up"
alias down="docker-compose down"
alias rw="docker-compose run web bundle exec rake resque:work QUEUE=*"
alias drdus="docker-compose down; RESEED=true docker-compose up"
alias drdu="docker-compose down; docker-compose up"
alias drnuke="docker container prune -f; docker volume prune -f; docker image prune -f"

dr_db() {
  containers=$(docker ps -a --format "{{.ID}} {{.Names}} {{.Image}}" | grep unsafe_postgres)
  target=$(echo $containers | $(fzf_prog) | awk '{ print $1 }')
  echo $containers | awk '{ print $1 }' | xargs -I NAME docker stop NAME > /dev/null
  docker start $target > /dev/null
}

dr_stop(){
  containers=$(docker ps --format "{{.ID}} {{.Names}} {{.Image}}" )
  target=$(echo $containers | $(fzf_prog) | awk '{ print $1 }')
  docker stop $target > /dev/null
}


