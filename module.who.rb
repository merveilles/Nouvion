class Answer
    # Available: moduleName,methodName,username,message

    def is
        username = @message.split(' ')[2].lstrip.rstrip

        @memory.connect
        thoughts = @memory.load(username).shuffle

        definition = ''
        twitter = ''
        collaborations = 0
        collaborationsString = ''
        location = ''

        thoughts.each do |known|
            if known[1] == username then definition = known[2] end
            if known[0] == username && known[1] == 'my twitter' then twitter   = "This user's Twitter is <https://twitter.com/" + known[2] + '|@' + known[2] + '>. ' end
            if known[0] == username && known[1] == 'my location' then location = 'Currently located in *' + known[2] + '*. ' end
            if known[0] == username then collaborations += 1 end
        end

        if collaborations > 0
            collaborationsString = "\n*" + username.capitalize + "* has added *#{collaborations} entries* to my memory. "
        end

        if definition == '' then return "I do not know *#{username}*." end

        '*' + username.capitalize + '* is ' + definition + ". \n" + location + twitter + collaborationsString
    end

    def am
        @memory.connect
        thoughts = @memory.load(@username).shuffle

        thoughts.each do |known|
            if known[1] != @username then next end
            return '*You* are ' + known[2] + '.'
        end

        'I do not know you.'
    end

    def told
        matches = @message.match(/(.*)who told you that (.+) is (.+)/)
        if matches.nil? then return end
        prefix, topic, meaning = matches.captures

        find_author(topic.strip, meaning.strip, 'told me')
    end

    def said
        matches = @message.match(/(.*)who said that (.+) is (.+)/)
        if matches.nil? then return end
        prefix, topic, meaning = matches.captures

        find_author(topic.strip, meaning.strip, 'said')
    end

    def find_author(topic, meaning, formulation)
        if topic == '' || meaning == '' then return end

        @memory.connect
        thoughts = @memory.load(topic)

        authors = thoughts.select { |x| x[1] == topic && x[2] == meaning }.map { |x| x[0] }.uniq

        if authors.size > 1 then
            return "*#{authors.join('*, *')}* #{formulation} that _#{topic}_ is _#{meaning}_."
        end
        if authors.size == 1 then
            return "*#{authors[0]}* #{formulation} that _#{topic}_ is _#{meaning}_."
        end

        "Nobody #{formulation} that."
    end
end
