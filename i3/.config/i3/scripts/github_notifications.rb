#!/usr/bin/env /home/sroberts/.rubies/ruby-2.7.4/bin/ruby
require 'json'

if ENV["BLOCK_BUTTON"].to_i == 1
  `firefox https://github.com/notifications`
end

TOKEN = File.readlines("#{ ENV['HOME'] }/.github_token").first.chomp

notifications = JSON.parse(`curl --silent -H "Authorization: token #{ TOKEN }" "https://api.github.com/notifications"`)

if notifications.any?
  puts notifications.size
end
