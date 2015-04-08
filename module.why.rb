class Answer
	def why
		if @username == 'slackbot' then return end

		query = @message.sub('why do', '').strip

		@memory.connect
		thoughts = @memory.load(query)

		thoughts.each do |known|
			if known[0] == 'ludivine' then next end
			return 'Because of *' + nlpResponse(known[2]) + '*.'
		end

		"I don't know? Tell me."
	end

 def nlpResponse(words)
     words = ' ' + words + ' '
     words = words.sub(' my ', ' _your_ ')
     words = words.sub(' me ', ' _you_ ')
     words = words.sub(' your ', ' _my_ ')
     words = words.sub(' you ', ' _me_ ')
     words = words.sub(' i ', ' _you_ ')
     words = words.sub(' you ', ' _I_ ')
     words = words.gsub('_', '')

     words.strip
 end
end
