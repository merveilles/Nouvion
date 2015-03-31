class Answer

	# Available: moduleName,methodName,username,message

	def time

		return Hash["text" => "The XXIIV server time is "+Time.new.strftime("%H:%M:%S")+"."]

	end


	def day
		return Hash["text" => "We are the "+Time.new.strftime("%B %d, %Y")+"."]
	end
	
end