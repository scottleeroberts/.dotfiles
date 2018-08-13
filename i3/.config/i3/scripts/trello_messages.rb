#!/usr/bin/env ruby
require 'yaml'
require 'uri'
require 'json'
require 'net/http'

CONFIG = YAML.load(File.open("#{ ENV['HOME'] }/.trello.yml"))
member_id = CONFIG.fetch('trello').fetch('member_id')
key = CONFIG.fetch('trello').fetch('key')
token = CONFIG.fetch('trello').fetch('token')
username = CONFIG.fetch('trello').fetch('username')

if ENV['BLOCK_BUTTON'].to_i == 1
  `firefox www.trello.com/"#{username}"/notifications`
end

url = URI("https://api.trello.com/1/members/#{member_id}/notifications?read_filter=unread&key=#{key}&token=#{token}")
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

response = Net::HTTP.get(url)
count = JSON.parse(response).count
puts count if count > 0
