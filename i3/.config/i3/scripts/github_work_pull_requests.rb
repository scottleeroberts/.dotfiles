#!/usr/bin/env /home/sroberts/.rubies/ruby-2.6.3/bin/ruby
# frozen_string_literal: true

require 'json'

TOKEN = File.readlines("#{ENV['HOME']}/.github_token").first.chomp

if ENV['BLOCK_BUTTON'].to_i == 1
  `firefox https://github.com/BaldwinAviation/baldwin-web/pulls`
end

class PullRequests
  READY_TO_REVIEW_LABEL = 'Ready For Review'
  CHANGES_REQUESTED_LABEL = 'Changes Requested'
  ALREADY_REVIEWED_LABEL = 'Scott Signed Off'
  GITHUB_USERNAME = 'scottleeroberts'
  REPO = 'baldwinaviation/baldwin-web'
  AWAITING_RESPONSE_LABEL = 'Awaiting Response'

  def self.process
    new.process
  end

  def process
    return unless needs_attention_count.positive?

    puts needs_attention_count
  end

  private

  def my_pull_requests
    pull_requests.select { |pr| pr.creator == GITHUB_USERNAME }
  end

  def needs_attention_count
    my_reviewed_pull_requests.size + pull_requests_to_review.size
  end

  def my_reviewed_pull_requests
    my_pull_requests.select { |pr| pr.labels.include?(CHANGES_REQUESTED_LABEL) } +
      my_pull_requests.select { |pr| pr.labels.include?(AWAITING_RESPONSE_LABEL) }
  end

  def pull_requests_to_review
    pull_requests
      .reject { |pr| pr.creator == GITHUB_USERNAME }
      .reject { |pr| pr.labels.include?(ALREADY_REVIEWED_LABEL) }
      .select { |pr| pr.labels.include?(READY_TO_REVIEW_LABEL) }
  end

  def pull_requests
    @pull_requests ||=
      JSON
      .parse(`curl --silent -H "Authorization: token #{TOKEN}" -H "Content-Type: application/json" "https://api.github.com/repos/#{REPO}/issues"`)
      .select { |e| e.key?('pull_request') }
      .map { |e| PullRequest.new(e) }
  end

  class PullRequest
    attr_reader :labels

    def initialize(json_data)
      @json_data = json_data
    end

    def creator
      json_data.fetch('user').fetch('login')
    end

    def labels
      @labels ||= json_data.fetch('labels').map { |e| e.fetch('name') }
    end

    private

    attr_reader :json_data
  end
end

PullRequests.process
