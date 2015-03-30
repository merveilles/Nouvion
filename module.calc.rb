class Answer

	# Available: moduleName,methodName,username,message

	def calc # ludivine calc 1 + 2

		oper = @message.split(" ")[0]
		val1 = @message.split(" ")[1].to_i
		val2 = @message.split(" ")[2].to_i

	  	return Hash["text" => "Module by Aliceffekt."]

	end

	def add 

		val1 = @message.split(" ")[2].to_i
		val2 = @message.split(" ")[3].to_i

	  	return Hash["text" => "The sum of #{val1} and #{val2}, is "+(val1+val2).to_s+"."]

	end
	
end