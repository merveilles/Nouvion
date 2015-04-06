class Answer

    # Available: moduleName,methodName,username,message

    def time

        time = Time.new.strftime("%H:%M:%S")
        return "The XXIIVV server time is #{time}"

    end

    def day

        day = Time.new.strftime("%B %d, %Y")
        return "We are the #{day}."

    end

    def month

        desamber = [
            "Monuary",
            "Dotuary",
            "Trisuary",
            "Tetruary",
            "Pentuary",
            "Hexuary",
            "Septamber",
            "Octamber",
            "Enneamber",
            "Desamber",
            "Undesamber",
            "Dodesamber"
        ]

        month = desamber[Time.now.month - 1]

        return "The XXIIVV Month is #{month}"

    end

    def is

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
