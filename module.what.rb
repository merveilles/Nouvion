class Answer

	# Available: moduleName,methodName,username,message

	def time
		return Hash["text" => "The XXIIV server time is "+Time.new.strftime("%H:%M:%S")+"."]
	end

	def day
		return Hash["text" => "We are the "+Time.new.strftime("%B %d, %Y")+"."]
	end

	def is
		@memory.connect()
		query = @message.sub("what is ","").strip
	    thoughts = @memory.load(query).shuffle

		if thoughts.length > 1
	      return Hash["text" => "*"+thoughts[0][1]+"* is *"+thoughts[0][2]+"* and *"+thoughts[1][2]+"*."]
	    elsif thoughts.length > 0
	      return Hash["text" => "*"+thoughts[0][1]+"* is *"+thoughts[0][2]+"*."]
	    end
	    return Hash["text" => "I don't know.."]
	end
	
end