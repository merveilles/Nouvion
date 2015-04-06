class Answer

    @@professions = {
        "peasant" => "throws a rock at",
        "fighter" => "swings their sword at",
        "rogue" => "blends with the shadows and backstabs",
        "mage" => "casts a fireball at",
        "necromancer" => "sics a ghoul on"
    }

    def battle

        return "Choose a user for me to `attack` `heal` or `raise` - or request to see the `scores`."

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

    def profession
        all_professions = @@professions.keys

        current_profession = all_professions[0]

        @memory.connect()

        thoughts = @memory.load("profession")

        thoughts.each do |known|
          if known[0] != @username then next end
          if known[1] != "profession" then next end
          if known[2] != nil
            current_profession = known[2]
            break
          end
        end

        params = @message.sub("battle profession","").split(" ") # i'm seeing all kinds of problems if a user has a name which is a resevered word.

        if params.length == 0 then
            return "Your current profession is #{current_profession}"
        else
            new_profession = params[0]
        end

        if !all_professions.include?(new_profession) then
            return "You need to select a proper profession among these: #{all_professions}"
        end

        if current_profession == new_profession then
           return "#{@username}, you already are a #{new_profession}"
        end

        @memory.save(@username, "profession", new_profession)

        return "#{@username} has changed profession from #{current_profession} to #{new_profession}"
    end

    def attack
        all_professions = @@professions.keys

        target = @message.sub("attack","").split(" ")[1]
        damage = 1

        if target == "ludivine"
            target = @username
            damage = 10
        end

        # get HP

        @memory.connect()

        current_profession = all_professions[0]

        thoughts = @memory.load("profession")

        thoughts.each do |known|
          if known[0] != @username then next end
          if known[1] != "profession" then next end
          if known[2] != nil
            current_profession = known[2]
            break
          end
        end

        battle_message = "#{@username} #{@@professions[current_profession]} *#{target}*."

        thoughts = @memory.load("health ")

        thoughts.each do |known|
            if known[0] != "ludivine" then next end
            if known[1] != "health "+target then next end

            hp = known[2].to_i
            if hp < 1 then return "*#{target}* is dead.." end

            hp -= damage

            @memory.save("ludivine","health #{target}",hp.to_s)

            if (hp) < 1
                return "#{battle_message}, killing them!"
            else
                return "#{battle_message}, down to *"+hp.to_s+"hp*!"
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
