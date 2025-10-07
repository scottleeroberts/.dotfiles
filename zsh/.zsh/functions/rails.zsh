alias console="bundle exec rails console"

alias be="bundle exec"
alias bu="bundle update"
alias bi="bundle install && bundle install --force-local"

alias ber="bundle exec rails"
alias bes="bundle exec rspec"
alias bep="bundle exec rake parallel:spec[$RSPEC_CORES] RAILS_ENV=test"

alias mi="bundle exec rake db:migrate RAILS_ENV=development"
alias mit="bundle exec rake db:migrate RAILS_ENV=test"
alias pmit="bundle exec rake parallel:migrate[$RSPEC_CORES]"

alias clean_devdb="bundle exec rake db:drop db:setup RAILS_ENV=development"
alias clean_testdb="bundle exec rake db:drop db:setup RAILS_ENV=test"
alias pclean_testdb="bundle exec rake parallel:drop[$RSPEC_CORES] parallel:setup[$RSPEC_CORES] RAILS_ENV=test"

alias rl="bundle exec rails routes | rg"
