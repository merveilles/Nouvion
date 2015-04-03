class Answer

    def remember

        @memory.connect()

        if @message.split(" ")[1] == "that"
            @message = @message.sub("that", "").strip
        end
        
        @message = @message.sub("remember", "").strip
        
        termSplit = termToSplit(@message)
        name = termSplit[0]
        value = termSplit[1]
        term = termSplit[2]
        
        if value.include?("http")
            return Hash["text" => "I cannot remember URLs."]
        end
        
        if name != "" && value != "" && term != ""
            @memory.save(@username, name, value)
            return Hash["text" => "I will remember that *#{name}*" + term + "*#{value}*."]
        end
        
        return Hash["text" => "What do you want me to remember #{@username}?"]

    end
    
    def termToSplit(msg)
        terms = ["is", "are", "have", "has"]
        if msg.split(" ").length > 2
            for term in terms
                name = msg.split(" " + term + " ")[0].to_s.strip
                value = msg.split(" " + term + " ")[1].to_s.strip
                if name != "" && value != ""
                    return [name, value, " " + term + " "]
                end
            end
        end
        return ["", "", ""]
    end

end
