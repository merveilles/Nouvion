class Answer

    # Available: moduleName,methodName,username,message

    def compile

        @memory.connect()
    	query = @message.sub("compile", "").strip

    	if query == ""
    		return "You must give me something to compile.\n`compile something`"
    	end

    	thoughts = @memory.load(query).shuffle

    	votes = {}
    	votesSum = 0

    	thoughts.each do |known|
    		if known[1] != query then next end
    		votes[known[2]] = votes[known[2]].to_i + 1
    		votesSum += 1
    	end

    	if votesSum < 1
	    	return "I don't know what *"+query+"* is."
	    end

        totalPercents = 0
        otherVotes = 0
    	graph = ""
    	votes.sort_by {|_key, value| value}.reverse.each do |value,count|
    		percent = ((count.to_f/votesSum.to_f)*100).to_i
            if percent < 10
                otherVotes += 1
                next
            end
            totalPercents += percent
    		graph += progressBar(percent)+" *"+value+"* has "+count.to_s+" votes, for "+percent.to_s+"%\n"
    	end

        if totalPercents > 3 && otherVotes > 0
           graph += "And *"+otherVotes.to_s+" misc votes*, for "+(100-totalPercents).to_s+"%..\n" 
        end

    	return "The result for "+query+" is: \n"+graph

    end

    def progressBar percent

    	graph = ""

    	i = 0
    	while i < percent/10
    		graph += "="
    		i += 1
    	end 

    	space = 0
    	while space < (10-i)
    		graph += " "
    		space += 1
    	end

        if graph.strip == ""
            graph += "__________"
        end

    	return "`"+graph+"`"

    end

end