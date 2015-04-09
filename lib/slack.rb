module Slack
    @token = ENV['SLACK_TOKEN']

    private

    def self.token
        return @token
    end
end

require 'net/http'
require 'json'

require 'slack/auth'
require 'slack/rtm'
require 'slack/users'
