module Nouvion::Handlers
    class Message
        def initialize(data)
            @type = data['type']
        end

        def handle
            puts "Handling #{@type} message."
        end
    end
end
