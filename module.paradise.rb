class Answer

	def count

		query = @message.sub("paradise count","").strip

        @memory.connect()
        thoughts = @memory.paradise(query)

		return "There are *"+thoughts.length.to_s+"* mentions of _#{query}_ on <http://wiki.xxiivv.com/paradise|Paradise>."


	end
end