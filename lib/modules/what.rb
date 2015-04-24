require 'api'

class Answer
    def is
        message = @message.split(' ')

        term = message[2]
        definition = ''
        relation = ''

        if USERS_BY_NAME[term] != nil
            return "<@#{@username}>: #{term} is a *who*, not a *what*!"
        end

        remember = API::Remember.new(@username)

        entries = remember.recall(term)

        entries.each do |entry|
            definition = entry[3]
            relation = entry[4]

            if entry[1] == USERS[@username]
                break
            end
        end

        if definition == ''
            return "<@#{@username}>: I do not know *#{term}*."
        end

        return "<@#{@username}>: *#{term.capitalize}* #{relation} *#{definition}*."
    end
end
