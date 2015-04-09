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
        end
    end
end
