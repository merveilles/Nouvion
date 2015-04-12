require 'modules/answer'

module Nouvion::Handlers
    class Message
        def initialize(data)
            @type = data['type']
            @channel = data['channel']

            unless data.has_key?('message')
                @user = data['user']
                @text = data['text']
            else
                @user = data['message']['user']
                @text = data['message']['text']
            end

            @text = sanitize(@text)

            puts @text
        end

        def handle
            message = @text.split(' ')

            unless message[0].gsub(':', '').downcase == 'nouvion'
                return
            else
                message.shift
            end

            module_name = sanitize(message[0])
            method_name = sanitize(message[1])

            if File.exist?("lib/modules/#{module_name}.rb")
                require "modules/#{module_name}"
            end

            answer = Answer.new(module_name, method_name, @user, @channel, message.join(' '))

            response = ''

            unless module_name == ''
                unless method_name == ''
                    if answer.respond_to?(method_name)
                        response = answer.send(method_name)
                    elsif answer.respond_to?(module_name)
                        response = answer.send(module_name)
                    else
                        response = 'Unknown method.'
                    end
                else
                    if answer.respond_to?(module_name)
                        response = answer.send(module_name)
                    else
                        response = 'Unknown module.'
                    end
                end
            else
                response = 'Huh?'
            end

            Slack::Chat.post_message(@channel, response)
        end

        private

        def sanitize(string)
            string = string || ''

            return string.gsub(/[^0-9A-Z\s\-_]/i, '').downcase
        end
    end
end
