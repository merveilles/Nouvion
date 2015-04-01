class Answer

    # Available: moduleName,methodName,username,message

    def time
        return Hash["text" => "The XXIIVV server time is "+Time.new.strftime("%H:%M:%S")+"."]
    end

    def day
        return Hash["text" => "We are the "+Time.new.strftime("%B %d, %Y")+"."]
    end

    def is
        @memory.connect()
        query = @message.sub("what is","").strip
        thoughts = @memory.load(query).shuffle

        # Any message

        if thoughts.length < 1 then return Hash["text" => "I don't know"] end

        # Look for a message by the user

        thoughts.each do |known|
            if known[0] != @username then next end
            return Hash["text" => "*"+known[1]+"* is *"+known[2].sub("my","your").strip+"*."]
        end

        # Look for any message

        if @message.include?("twitter") && thoughts.length > 0
            username = thoughts[0][2]
            return Hash["text" => "*#{thoughts[0][1]}* is <https://twitter.com/#{username}|@#{username}>."]
        end

        if thoughts.length > 1
          return Hash["text" => "*"+thoughts[0][1]+"* is *"+thoughts[0][2]+"* and *"+thoughts[1][2]+"*."]
        elsif thoughts.length > 0
          return Hash["text" => "*"+thoughts[0][1]+"* is *"+thoughts[0][2]+"*."]
        end

        return Hash["text" => "I don't know.."]
    end

end
