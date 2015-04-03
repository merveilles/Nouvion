class Answer

    def battle

        return "Choose a user for me to `attack` `heal` or `raise` - or request to see the `scores`."]

    end

    def scores

        @memory.connect()
        thoughts = @memory.load("health ")

        scores = ""
        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1].split(" ")[0] != "health" then next end
            if known[2].to_i < 1
                scores += "*"+known[1].sub("health","")+"* _dead_\n"
            else
                scores += "*"+known[1].sub("health","")+"* "+known[2]+"hp\n"
            end

        end
        return "Your scores are:\n#{scores}"

    end

    def attack

        target = @message.sub("attack","").split(" ")[1]
        damage = 1

        if target == "ludivine"
            target = @username
            damage = 10
        end

        # get HP

        @memory.connect()
        thoughts = @memory.load("health ")

        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1] != "health "+target then next end

            if known[2].to_i < 1 then return "*#{target}* is dead.." end

            @memory.save("ludivine","health #{target}",(known[2].to_i - damage).to_s)

            if (known[2].to_i - damage) < 1
                return "I killed *#{target}*!"
            else
                return "I am attacking *#{target}* down to *"+((known[2].to_i - damage).to_s)+"hp*!"
            end


        end

        # New player

        @memory.save("ludivine","health #{target}","10")
        return "A new pet, *#{target}* joins my arena."

    end

    def heal

        target = @message.sub("heal","").split(" ")[1]

        # get HP

        @memory.connect()
        thoughts = @memory.load("health ")

        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1] != "health "+target then next end

            if known[2].to_i > 15 then return "*#{target}*'s health is full.." end
            if known[2].to_i < 1  then return "*#{target}* is dead.." end

            @memory.save("ludivine","health *#{target}*",(known[2].to_i + 1).to_s)
            return "I healed *#{target}* up to *"+((known[2].to_i + 1).to_s)+"hp*!"

        end

        return "I don't have a pet named *#{target}*."

    end

    def raise

        target = @message.sub("raise","").split(" ")[1]

        # get HP

        @memory.connect()
        thoughts = @memory.load("health ")

        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1] != "health "+target then next end

            if known[2].to_i != 0 then return "*#{target}* is not dead.." end

            @memory.save("ludivine","health *#{target}*","5")
            return "I raised *#{target}* back to life with *5hp*!"

        end

        return "I don't have a pet named *#{target}*."

    end

end
