alias console="docker-compose run web bundle exec rails console"

docker_or_local() {

  if [[ -f docker-compose.yml ]]; then
    eval {"docker-compose run --rm --no-deps -e SKIP_SIMPLECOV=true web /bin/bash -c \"$@\""}
  else
    eval {"SKIP_SIMPLECOV=true $@"}
  fi
}

be() { docker_or_local "bundle exec $@" }
bu() { docker_or_local "bundle update $@" }

ber() { docker_or_local "bundle exec rails $@" }
bes() { docker_or_local "bundle exec rspec $@" }
bep() { docker_or_local "bundle exec rake parallel:spec[$RSPEC_CORES]" }
bi() { docker_or_local "bundle install $@" }
bemi() { docker_or_local "bundle exec rails generate migration $@" }

mi() { docker_or_local "bundle exec rake db:migrate RAILS_ENV=development" }
mit() { docker_or_local "bundle exec rake db:migrate RAILS_ENV=test" }
pmit() { docker_or_local "bundle exec rake parallel:migrate[$RSPEC_CORES]" }
rollback() { docker_or_local "bundle exec rake db:rollback RAILS_ENV=development" }

rrq() { docker_or_local "bundle exec rails resque:work QUEUES=*" }
rrs() { docker_or_local "bundle exec rake resque:scheduler" }

clean_devdb() { docker_or_local "bundle exec rake db:drop db:setup RAILS_ENV=development" }
clean_testdb() { docker_or_local "bundle exec rake db:drop db:setup RAILS_ENV=test" }
pclean_testdb() { docker_or_local "bundle exec rake parallel:drop[$RSPEC_CORES] parallel:setup[$RSPEC_CORES] RAILS_ENV=test" }

ya() { docker_or_local "yarn $@" }
edit_credentials() {
  docker_or_local "apt-get install -y vim && EDITOR=vim bundle exec rails credentials:edit --environment=$@"
}
