#!/usr/bin/env /home/sroberts/.rubies/ruby-3.1.1/bin/ruby
require 'json'

`firefox https://github.com/notifications` if ENV['BLOCK_BUTTON'].to_i == 1

TOKEN = File.readlines("#{ENV['HOME']}/.github_token").first.chomp

notifications = JSON.parse(`curl --silent -H "Authorization: token #{TOKEN}" "https://api.github.com/notifications"`)

puts notifications.size if notifications.any?
