require 'erb'
include ERB::Util

class Answer
    def get_term(msg)
        terms = msg.split(' ')

        if terms.length > 2
            term = terms.drop(2).join(' ')
        end

        term = !term.nil? ? term.lstrip.rstrip : 'cat fact'
        term = url_encode(term)

        term
    end

    def search
        terms = @message.split(' ')

        if terms.length > 1
            term = terms.drop(1).join(' ')
        end

        term = !term.nil? ? term.lstrip.rstrip : 'cat fact'
        term = url_encode(term)

        return "Is <http://www.google.com/search?q=#{term}&btnI|this> what you're looking for?"
    end

    def google
        term = get_term(@message)

        return "http://www.google.com/search?q=#{term}&btnI"
    end

    def duckduckgo
        term = get_term(@message)

        return "https://duckduckgo.com/?q=!ducky+#{term}+%s"
    end
end
