class Answer

	# Available: moduleName,methodName,username,message

	def is

		username = @message.split(" ")[2]

		vessels = {}
		vessels["aliceffekt"] = "many witches"
		vessels["theneko"] = "a cat"
		vessels["3wm"] = "a single wise man"
		vessels["maxdeviant"] = "actually Marshall"
		vessels["cancel"] = "someone very clever"
		vessels["ciel"] = "the koi"
		vessels["bluelion"] = "a Mu traveler"

		if vessels[username] then return Hash["text" => "*@#{username}* is "+vessels[username]+"."] end

		return Hash["text" => "I do not know *#{username}*."]

	end
	
end
