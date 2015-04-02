class Answer

	def battle

		return Hash["text" => "Choose a user for me to `attack` `heal` or `raise`."]		

	end

	def attack

		target = @message.sub("attack","").split(" ")[1]

		if target == "ludivine" then target = @username end

		# get HP

		@memory.connect()
		thoughts = @memory.load("health ")

		thoughts.each do |known|
			if known[0] != "ludivine" then next end
			if known[1] != "health "+target then next end

			if known[2].to_i < 1 then return Hash["text" => "*#{target}* is dead.."] end

			@memory.save("ludivine","health #{target}",(known[2].to_i - 1).to_s)

			if (known[2].to_i - 1) < 1 
				return Hash["text" => "I killed *#{target}*!"]
			else
				return Hash["text" => "I am attacking *#{target}* down to *"+((known[2].to_i - 1).to_s)+"hp*!"]
			end
			

		end

		# New player

		@memory.save("ludivine","health #{target}","10")
		return Hash["text" => "A new pet, *#{target}* joins my arena."]

	end

	def heal

		target = @message.sub("heal","").split(" ")[1]

		# get HP

		@memory.connect()
		thoughts = @memory.load("health ")

		thoughts.each do |known|
			if known[0] != "ludivine" then next end
			if known[1] != "health "+target then next end

			if known[2].to_i > 15 then return Hash["text" => "*#{target}*'s health is full.."] end
			if known[2].to_i < 1  then return Hash["text" => "*#{target}* is dead.."] end

			@memory.save("ludivine","health *#{target}*",(known[2].to_i + 1).to_s)
			return Hash["text" => "I healed *#{target}* up to *"+((known[2].to_i + 1).to_s)+"hp*!"]

		end

		return Hash["text" => "I don't have a pet named *#{target}*."]

	end

	def raise

		target = @message.sub("raise","").split(" ")[1]

		# get HP

		@memory.connect()
		thoughts = @memory.load("health ")

		thoughts.each do |known|
			if known[0] != "ludivine" then next end
			if known[1] != "health "+target then next end

			if known[2].to_i != 0 then return Hash["text" => "*#{target}* is not dead.."] end

			@memory.save("ludivine","health *#{target}*","5")
			return Hash["text" => "I raised *#{target}* back to life with *5hp*!"]

		end

		return Hash["text" => "I don't have a pet named *#{target}*."]

	end

end