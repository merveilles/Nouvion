require 'api'

class Answer
    def remember
        remember = API::Remember.new(@username)

        if @message.split(' ')[1] == 'that'
            @message = @message.sub('that', '').strip
        end

        @message = @message.sub('remember', '').strip

        term_split = term_to_split(@message)
        name = term_split[0]
        value = term_split[1]
        term = term_split[2]

        if name != '' && value != '' && term != ''
            remember.store(name, value, term)

            return 'I will remember that *' + nlp_response(name) + '* ' + term + " *#{value}*."
        end

        "What do you want me to remember <#{@username}>?"
    end

    def nlp_response(words)
        words = ' ' + words + ' '
        words = words.sub(' my ', ' _your_ ')
        words = words.sub(' me ', ' _you_ ')
        words = words.sub(' your ', ' _my_ ')
        words = words.sub(' you ', ' _me_ ')
        words = words.gsub('_', '')

        words.strip
    end

    def term_to_split(msg)
        terms = %w(is are have has)

        if msg.split(' ').length > 2
            for term in terms
                name = msg.split(' ' + term + ' ')[0].to_s.strip
                value = msg.split(' ' + term + ' ')[1].to_s.strip
                if name != '' && value != ''
                    return [name, value, term]
                end
            end
        end

        return ['', '', '']
    end
end
