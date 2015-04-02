class Answer

    # Available: moduleName,methodName,username,message

    def vesselsArray

        vessels = {
            "aliceffekt" => "many witches",
            "theneko" => "a cat",
            "3wm" => "a single wise man",
            "maxdeviant" => "actually Marshall",
            "nestor" => "@maxdeviant's undead butler",
            "cancel" => "someone very clever",
            "ciel" => "the koi",
            "ludivine" => "the past of the future singularity",
            "greylion" => "a Mu traveler",
            "somnius" => "a tiger who codes",
            "slackbot" => "no one",
            "floatvoid" => "a robot trapped in a flesh-suit",
            "phrhd" => "a house of haunted spirits",
            "christian" => "a tamer of basilisks",
            "nullfruit" => "a dead pixel",
            "horsman" => "a continuous effort to become a ghost",
            "d6" => "six faces, twenty-one unblinking eyes",
            "dualhammers" => "a pair of sentient tools",
            "poka" => "a key",
            "ragekit" => "an unstable thaumaturgist"
        }

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
