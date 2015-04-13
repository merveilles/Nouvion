require 'api'

class Answer
    def recommend
        message = @message.gsub('recommend', '').strip.split(' ')

        for_index = message.rindex('for')

        if !for_index.nil?
            topic = message.take(for_index).join(' ')
            target = message.drop(for_index + 1).join(' ')
        else
            topic = message.join(' ')
            target = @username
        end

        remember = API::Remember.new(@username)
        entries = remember.recall(topic)

        entries.each do |entry|
            unless entry[3].include?(topic) then next end

            return "How about *#{entry[2]}*, <@#{target}>?"
        end

        "<@#{@username}>: What is *#{topic}*?"
    end
end
