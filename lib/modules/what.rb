require 'api'

class Answer
    def is
        message = @message.split(' ')

        term = message[2]
        definition = ''
        relation = ''

        puts term
        puts USER_NAMES[term]

        puts USER_NAMES

        if USER_NAMES[term] != nil
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

        return "<@#{@username}>: *#{term.capitalize}* #{relation} *#{definition}*."
    end
end
