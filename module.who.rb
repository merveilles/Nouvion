class Answer

	# Available: moduleName,methodName,username,message

	def vesselsArray

		vessels = {}

		vessels["aliceffekt"] = "many witches"
		vessels["theneko"] = "a cat"
		vessels["3wm"] = "a single wise man"
		vessels["maxdeviant"] = "actually Marshall"
		vessels["cancel"] = "someone very clever"
		vessels["ciel"] = "the koi"
		vessels["ludivine"] = "the past of the future singularity"
		vessels["bluelion"] = "a Mu traveler"
		vessels["slackbot"] = "no one"
		vessels["floatvoid"] = "a robot trapped in a flesh-suit"

		return vessels
	end

	def is

		vessels = vesselsArray

		username = @message.split(" ")[2].lstrip.rstrip

		if vessels[username] && username == @username then return Hash["text" => "You are "+vessels[username]+"."]
		elsif vessels[username] then return Hash["text" => "*@#{username}* is "+vessels[username]+"."] end

		return Hash["text" => "I do not know *#{username}*."]

	end

	def am

		vessels = vesselsArray

		if vessels[@username] then return Hash["text" => "You are "+vessels[@username]+"."] end
		return Hash["text" => "I do not know you."]

	end
	
end
