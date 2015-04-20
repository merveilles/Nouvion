require 'api'

class Answer
    def is
        message = @message.split(' ')

        username = message[2]
        definition = ''

        if USER_NAMES[username] == nil
            return "<@#{@username}>: I do not know *#{username}*."
        end

        remember = API::Remember.new(@username)

        entries = remember.recall(username)

        entries.each do |entry|
            definition = entry[3]

            if entry[1] == USERS[@username] && entry[4] == 'is'
                break
            end
        end

        if definition == ''
            return "<@#{@username}>: I do not know *#{username}*."
        end

        return "<@#{@username}>: <@#{username}> is *#{definition}*."
    end
end
