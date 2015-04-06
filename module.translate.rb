class Answer

	def translate

		query = @message.split(" ")[1]

        @memory.connect()
        thoughts = @memory.traumae(query)

        thoughts.each do |known|
        	if known[2] == query then return "In <http://wiki.xxiivv.com/traumae|Traumae>, *#{query}* can be translated as _"+known[1]+"_." end
        	if known[1] == query then return "In English, the <http://w