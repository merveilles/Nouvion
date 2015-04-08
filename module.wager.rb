#schema for wager

#wager memory schema:
#[ludivine, "wager", "singularity"]  :  it's in there
#[ludivine, "wager singularity", "the singularity will arrive before 2065::Yes::No::????"]  :  It's got two options and the customary admission of ambiguity
#[ludivine, "wager status singularity", "open"]  :  the other value is closed::<result description>
#[ludivine, "wager bet singularity", "faun::2::30"]  :  faun is betting against the singularity coming for 30 xen
require 'memory_object'

class Answer
	def open
		@memory.connect()
		msgsp = @message.split('::')
		name = msgsp[2].trim
		question = msgsp[3].trim
		options = msgsp[4..msgsp.length].push '????' #??? is always a possibility
		#validate input
		if (/^[a-zA-Z0-9]*$/.match(name) == nil)
			return "Invalid short name. Wager name must only contain letters and numbers"
		end
		#ensure that the bet doesn't already exist
		nope = false
		betcall = "wager #{name}"
		for triple in @memory.load(betcall).each
			if triple[0] == 'ludivine' and triple[1] == betcall
				nope = true
				break
			end
		end
		if nope
			wdescription = MemoryObject.new(name, @memory).load_from_memory("wager").split('::')[0]
			return "there is already a bet with that name. It was all about #{wdescription}"
		end
		#OK cool let's do this
		@memory.save("ludivine", "wager", name)
		@memory.save("ludivine", "wager #{name}", description+'::'+options.join('::'))
		@memory.save("ludivine", "wager status #{name}", "open")
	end
	
	def bet
		@memory.connect()
		userMem = MemoryObject.new(@username, @memory)
		msgsp = @message.split(' ')
		name = msgsp[2]
		wagerMem = MemoryObject.new(name, @memory)
		betCall = "wager "
		option = msgsp[3].to_i
		amount = msgsp[4].to_i
		description = nil
		options = []
		if amount < 1
			return 'you must offer at least 1 xenon'
		end
		#check whether bet is open
		if wagerMem.load_from_memory("wager status") != "open"
			return "#{name} is no longer open for bets"
		end
		#fetch bet information
		for triple in @memory.load(betcall)
			if triple[0] == 'ludivine' and triple[1] == betcall
				splitted = triple[2].split('::')
				description = splitted[0]
				options = splitted[1..splitted.length]
				break
			end
		end
		#ensure that something was found
		if description == nil
			return "There is no such wager as #{name}"
		#ensure user hasn't already bet
		wagerBetQ = "wager bet #{name}"
		for triple in @memory.load(wagerBetQ)
			if triple[0] == "ludivine" and triple[1] == wagerBetQ
				betspl = triple[2].split("::")
				better = betspl[0]
				if better == @username
					betted = options[betspl[1].to_i]
					betAmount = betspl[2].to_i
					return "No. You've got #{betAmount}XEN locked in on \"#{betted}\", remember? You can never go back."
					#TODO, set a cron to repeat "never." to @username after 6 seconds of silence.
				end
			end
		end
		chosenOptionText = options[option]
		#banking
		userBalance = userMem.load_from_memory("wallet","0").to_i
		if userBalance < amount
			return "Your balance of #{userBalance}XEN is not enough to make a bet of #{amount}XEN."
		end
		#record bet
		@memory.save('ludivine', "bet #{name}", "#{@username}::#{option}::#{amount}")
		#report success
		return "Your stance on the the outcome of \"#{name}\" has been locked in as #{chosenOptionText}"
	end
	
	def list
		@memory.connect()
		status = @message.split(' ')[2].trim
		if status != "open" and status != "closed"
			return "invalid status specifier"
		end
		rets = []
		for triple in @memory.load("wager")
			if triple[0] == "ludivine" and triple[1] == "wager"
				if status == "open" and triple[2] == "open"
					rets.push(statusName)
				elsif status == "closed" and triple[2] != "open"
					statusOnClosing = triple[2].split('::')[1]
					rets.push("#{statusName}:(#{statusOnClosing})")
				end
			end
		end
		return rets.join '   '
	end
	
	def distribute_sum(sum, winners, givingFunction)
		winnersSum = winners.inject {|l,r| l+r}
		for winner in winners[0..-2]
			theIn = winner[2]
			theTake = (sum*theIn)/winnersSum
			sum = sum - theTake
			givingFunction(winner[0],theTake)
		end
		givingFunction(winners[-1][0],remainingSum)
	end
	
	def report
		@memory.connect()
		betName = @message.split(' ')[2]
		reportedOutcome = @message.split(' ')[3].to_i
		wagerMem = MemoryObject.new(betName, @memory)
		optionName = wagerMem.load_from_memory("wager").split('::')[1..-1][reportedOutcome]
		
		#just accept it and reallocate the funds
		losers = []
		winners = []
		for v in wagerInfo.get_all_values_of_type("wager bet")
			vspl = v.split('::')
			if vspl[1].to_i == reportedOutcome
				winners.push vspl
			else
				losers.push vspl
			end
		end
		losersSum = losers.inject {|l,r| l+r}
		
		#take from the losers
		for loser in losers
			loserMem = MemoryObject.new(loser[0],@memory)
			loserMem.save_to_memory("wallet", (loserMem.load_from_memory("wallet").to_i - loser[2]).to_s)
		end
		#give to the winners
		#start by ordering them at random so remainder effects are distributed randomly
		remainingSum = losersSum
		winnersShuffled = winners.shuffle
		def give(userName,take)
			winnerMem = MemoryObject.new(userName,@memory)
			winnerMem.save_to_memory("wallet", (winnerMem.load_from_memory("wallet").to_i + take).to_s)
		end
		distribute_sum(remainingSum, winnersShuffled, give)
		#close bet
		wagerMem.save_to_memory("wager status", "closed::#{optionName}")
		return "You say it turned out that #{optionName}? Well that settles it. Reallocating xenon accordingly."
	end
	
	def info
		@memory.connect()
		betName = @message.split(' ')[2]
		wagerInfo = MemoryObject.new(betName,@memory).load_from_memory("wager").split('::')
		optionString = wagerInfo[1..-1].each_with_index.map {|desc,num| return "##{num}, #{desc}."}.join("\n")
		return "#{betName}. #{wagerInfo[0]}. Options are as follows.\n#{optionString}"
	end
	
	def help
		return 'Wager cold, hard Xenon to demonstrate your confidence in your predictions, for fun and profit. When your future event of interest transpires, report the way things went to ludivine and the money put forth by the wrong ones will go to the right ones. Takings are distributed to the victors in proportion to the amount they put forth. Do not fall into debt or the bank will sell you to sex trafficers.
bet <betName> <optionNumber> <amount>
info <betName>
list (open|closed)
open <betName>::<bet description, spaces allowed>::[<description of outcome>::]*
report <betName> <optionNumber>
'
	end
end