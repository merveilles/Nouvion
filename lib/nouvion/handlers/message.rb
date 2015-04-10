require 'modules/answer'

module Nouvion::Handlers
    class Message
        def initialize(data)
            @type = data['type']
            @channel = data['channel']
            @user = data['user']
            @text = data['text']
        end

        def handle
            puts "Handling #{@type} message."

            message = @text.split(' ')

            unless message[0] == 'nouvion' || message[0] == 'nouvion:'
                return
            end

            puts message

            if message[0] == 'nouvion' || message[0] == 'nouvion:'
                module_name = clean(message[1])
                method_name = clean(message[2])
            else
                module_name = clean(message[0])
                method_name = clean(message[1])
            end

            puts "#{module_name}.#{method_name}"

            puts Dir.entries('lib/modules')

            puts File.exist?("lib/modules/#{module_name}.rb")

            if File.exist?("lib/modules/#{module_name}.rb")
                require "modules/#{module_name}"
            end

            answer = Answer.new(module_name, method_name, @user, @channel, @text)

            unless module_name == ''
                unless method_name == ''
                    if answer.respond_to?(method_name)
                        puts answer.send(method_name)
                    elsif answer.respond_to(module_name)
                        puts answer.send(module_name)
                    else
                        puts 'Unknown method.'
                    end
                else
                    if answer.respond_to?(module_name)
                        puts answer.send(module_name)
                    else
                        puts 'Unknown module.'
                    end
                end
            else
                puts 'Huh?'
            end
        end

        private

        def clean(string)
            string = string || ''

            return string.gsub(/[^0-9A-Z]/i, '').downcase
        end
    end
end
