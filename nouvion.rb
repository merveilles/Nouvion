$LOAD_PATH.unshift(File.dirname(File.realpath(__FILE__)) + '/lib')

require 'dotenv'
Dotenv.load

require 'goliath'
require 'faye/websocket'
require 'json'
require 'nouvion'
require 'slack'

Faye::WebSocket.load_adapter('goliath')

class NouvionBot < Goliath::API
    def response(env)
        rtm_start = Slack::RTM.start

        Slack::Users.set_presence('auto')

        socket = Faye::WebSocket::Client.new(rtm_start['url'])

        socket.on :open do |event|
            puts 'listening'
        end

        socket.on :message do |event|
            data = JSON.parse(event.data)

            message =
                case data['type']
                when 'user_typing'
                    Nouvion::Handlers::UserTyping.new(data)
                else
                    Nouvion::Handlers::Message.new(data)
                end

            message.handle
        end

        socket.on :close do |event|
            puts 'closed'
        end

        return [200, {}, Goliath::Response::STREAMING]
    end
end
