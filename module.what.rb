class Answer

    def what

        if @message.include?("color")
            includeModule("color")
            if @message.include?("aura")  then return aura  end
            if @message.include?("today") then return today end
        end

        if @message.include?("time") || @message.include?("day")
            includeModule("time")
            if @message.include?("time")  then return time end
            if @message.include?("day")  then return day end
        end

        return lookup

    end

    def lookup

        @memory.connect()
        query = @message.sub("what is", "").strip
        thoughts = @memory.load(query).shuffle

        # No answer
        if thoughts.length < 1 
	        return "I don't know what *"+query+"* is, but you can teach me about it \bby typing `remember that "+query+" is ` followed by a short definition."
        end

        keyAnswer = []
        valueAnswer = []

        # Find a a key answer
        thoughts.each do |known|
            if known[1] == query then keyAnswer = known end
            if known[2] == query then valueAnswer = known end
        end

        # Key Answer return
        if keyAnswer[1]

        	deepThoughts = @memory.load(keyAnswer[2]).shuffle
        	deepAnswer = ""
        	deepThoughts.each do |deepKnown|
        		if deepKnown[1] == keyAnswer[2] then deepAnswer = deepKnown[2] end
        	end

        	if deepAnswer != ""
        		return "*" + keyAnswer[1] + "* is *" + keyAnswer[2] + "*, "+deepAnswer+"."
        	else
        		return "*" + keyAnswer[1] + "* is *" + keyAnswer[2] + "*."
        	end
        end

        # Value Answer return
        if valueAnswer[1]
        	return "I don't know what *" + query + "* is. Is it like *"+valueAnswer[1]+"*?"
        end

        return ".."

    end
    
end
