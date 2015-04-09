module Nouvion::Handlers
    class UserTyping < Nouvion::Handlers::Message
        def initialize(data)
            @type = data['type']
            @channel = data['channel']
            @user = data['user']
        end

        def handle
            # This does not need to be handled
        end
    end
end
