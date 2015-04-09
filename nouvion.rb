$LOAD_PATH.unshift(File.dirname(File.realpath(__FILE__)) + '/lib')

require 'dotenv'
Dotenv.load

require 'goliath'
require 'faye/websocket'
require 'json'
require 'slack'

Faye::WebSocket.load_adapter('goliath')

class Nouvion < Goliath::API
    def response(env)
        rtm_start = Slack::RTM.start

        Slack::Users.set_presence('auto')

        socket = Faye::WebSocket::Client.new(rtm_start['url'])

        socket.on :open do |event|
            puts 'listening'
        end

        socket.on :message do |event|
            message = JSON.parse(event.data)

            puts message

            case message['type']
            when 'message'
                puts 'I found a message!'
            end
        end

        socket.on :close do |event|
            puts 'closed'
        end

        return [200, {}, Goliath::Response::STREAMING]
    end
end
