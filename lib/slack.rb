module Slack
    @base_url = 'https://slack.com/api/'
    @token = ENV['SLACK_TOKEN']

    private

    def self.base_url
        return @base_url
    end

    def self.token
        return @token
    end
end

require 'net/http'
require 'json'

require 'slack/auth'
require 'slack/chat'
require 'slack/rtm'
require 'slack/users'
