class Who < Answer

    # Available: moduleName,methodName,username,message

    def is

        username = @message.split(" ")[2].lstrip.rstrip

        @memory.connect()
        thoughts = @memory.load(username).shuffle

        thoughts.each do |known|
            if known[1] != username then next end
            return Hash["text" => "*"+username+"* is "+known[2]+"."]
        end

        return Hash["text" => "I do not know *#{username}*."]

    end

    def am

        @memory.connect()
        thoughts = @memory.load(@username).shuffle

        thoughts.each do |known|
            if known[1] != @username then next end
            return Hash["text" => "*You* are "+known[2]+"."]
        end

        return Hash["text" => "I do not know you."]

    end

end
