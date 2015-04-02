class Answer

    def remember

        @memory.connect()

        if @message.split(" ")[1] == "that"
            @message = @message.sub("that", "").strip
        end

        if @message.include?(" is ") && @message.split(" ").length > 3
            @message = @message.sub("remember", "").strip
            memoryName = @message.split(" is ")[0].to_s.strip
            memoryValue = @message.split(" is ")[1].to_s.strip

            if memoryValue.include?("http")
                return Hash["text" => "I cannot remember URLs."]
            elsif memoryName != "" && memoryValue != ""
                @memory.save(@username, memoryName, memoryValue)
                return Hash["text" => "I will remember that *#{memoryName}* is *#{memoryValue}*."]
            end

        end

        return Hash["text" => "What do you want me to remember #{@username}?"]

    end

end
