class Answer

	def paradise

		return "A work in-progress implementation of Paradise on Ludivine. The current methods are:\n`count `  `where is `"
	end

	def count

		query = @message.sub("paradise count","").strip

        @memory.connect()
        thoughts = @memory.paradise(query)

		return "There are *"+thoughts.length.to_s+"* mentions of _#{query}_ on <http://wiki.xxiivv.com/paradise|Paradise>."

	end

	def where

		query = @message.sub("paradise where is","").strip

        @memory.connect()
        thoughts = @memory.paradise(query)

        if thoughts.length < 1 then return "Could not find a vessel named *#{query}*." end

        vesselId = thoughts[0][0]
        vesselName = thoughts[0][1]
        vesselParent = thoughts[0][3]

        vesselParentArray = @memory.paradise(vesselParent)

        vesselLocation = vesselParentArray[0][1]

		return "In <http://wiki.xxiivv.com/paradise|Paradise>, *#{vesselName}* is in #{vesselLocation}."

	end

end