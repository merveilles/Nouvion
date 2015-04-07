class Answer

	def because

		@memory.connect()
		thoughts = @memory.load("last query "+@username).shuffle[0]

		if thoughts[2].to_s.strip == "" then return "mhm?" end

		# Strip message

		storeKey = thoughts[2]
		storeValue = @message.sub("because of","").sub("because","")

		# Erase last message

		@memory.save(@username,storeKey,storeValue)
		@memory.save("ludivine","last query "+@username,"")

		return "So, "+nlpResponse(storeKey)+" because of "+nlpResponse(storeValue)+".."

	end

    def nlpResponse words

        words = " "+words+" "
        words = words.sub(" my "," _your_ ")
        words = words.sub(" me "," _you_ ")
        words = words.sub(" your "," _my_ ")
        words = words.sub(" you "," _me_ ")
        words = words.sub(" i "," _you_ ")
        words = words.sub(" you "," _I_ ")
        words = words.gsub("_","")

        return words.strip

    