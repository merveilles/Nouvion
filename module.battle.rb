class Answer
    @@professions = {
      'peasant' => 'throws a rock at',
      'fighter' => 'swings their sword at',
      'rogue' => 'blends with the shadows and backstabs',
      'mage' => 'casts a fireball at',
      'necromancer' => 'sics a ghoul on'
    }

    def battle
        "Choose a user for me to `attack` `heal` & `raise` or request to see the `scores`.\nYou *must* be in <#ze-arena> to attack other players."
    end

    def profession
        p = @message.sub('battle profession', '').split(' ') # i'm seeing all kinds of problems if a user has a name which is a resevered word.

        combatant = Combatant.new(@username, @memory)

        if p.length == 0 then
            return "Your current profession is *#{combatant.profession}*."
        end

        combatant.change_profession(p[0])
    end

    def attack
        if @channel != '#ze-arena' then return 'Please take your fight into <#ze-arena>.' end

        p = @message.sub('battle attack', '').split(' ')

        if p.length == 0 then
            return 'You have to select a target'
        end

        targetname = @message.sub('attack', '').split(' ')[1]
        damage = 1

        # todo : validate target is actually somebody that exists in merveilles

        if targetname == 'ludivine' then
            targetname = @username
            damage = 10
        end

        attacker = Combatant.new(@username, @memory)
        target = Combatant.new(targetname, @memory)

        attacker.attack(target, damage)
    end

    def heal
        targetname = @message.sub('heal', '').split(' ')[1]

        target = Combatant.new(targetname, @memory)
        return target.heal(1)

        # get HP

        "I don't have a pet named *#{target}*."
    end

    def raise
        target = @message.sub('raise', '').split(' ')[1]

        # get HP

        @memory.connect
        thoughts = @memory.load('health ')

        thoughts.each do |known|
            if known[0] != 'ludivine' then next end
            if known[1] != 'health ' + target then next end

            if known[2].to_i != 0 then return "*#{target}* is not dead.." end

            @memory.save('ludivine', "health *#{target}*", '5')
            return "I raised *#{target}* back to life with *5hp*!"

        end

        "I don't have a pet named *#{target}*."
    end

    def scores
        @memory.connect
        thoughts = @memory.load('health ')

        scores = ''
        thoughts.each do |known|
            if known[0] != 'ludivine' then next end
            if known[1].split(' ')[0] != 'health' then next end
            if known[2].to_i < 1
                scores += '*' + known[1].sub('health', '') + "* _dead_\n"
            else
                scores += '*' + known[1].sub('health', '') + '* ' + known[2] + "hp\n"
            end

        end
        "Your scores are:\n#{scores}"
    end
end

############################
# TODO : MOVE THIS CLASS TO A UTILITY MODULE
############################
class MemoryObject
    attr_reader :name

    def initialize(name, memory)
        @name = name
        @memory = memory

        @memory.connect
    end

    def load_from_memory(attribute, default_value = nil)
        thoughts = @memory.load(attribute + ' ')

        thoughts.each do |known|
            if known[0] != 'ludivine' then next end # ludivine hosts all health
            if known[1] != "#{attribute} #{@name}" then next end

            return known[2]
        end

        @memory.save('ludivine', "#{@name} #{@attribute}", default_value.to_s) # add missing values to users that get instantiated as combatants
        default_value.to_s
    end

    def save_to_memory(attribute, value)
        @memory.save('ludivine', "#{attribute} #{@name}", value.to_s)
    end
end

############################
# TODO : MOVE THIS CLASS TO A SHARABLE MODULE
############################

class Combatant < MemoryObject
    @@all_professions = {
      'peasant' => 'throws a rock at',
      'fighter' => 'swings their sword at',
      'rogue' => 'blends with the shadows and backstabs',
      'mage' => 'casts a fireball at',
      'necromancer' => 'sics a ghoul on'
    }

    attr_reader :profession
    attr_reader :health

    def initialize(name, memory)
        super(name, memory)

        @health = load_from_memory('health', 10).to_i
        @profession = load_from_memory('profession', @@all_professions[0])
    end

    def attack(target, damage) # call this on the attacker, with target as argument
        battle_message = @@all_professions[@profession]

        if target.health < 1 then
          return "*#{target.name}* is already dead."
        end

        target.damage(damage)

        if (target.health) < 1 then
            return "#{@name} #{battle_message} #{target.name}, killing them!"
        else
            return "#{@name} #{battle_message} #{target.name}, down to *" + target.health.to_s + 'hp*!'
        end
    end

    def heal(amount)
        if @health >= 15 then
            return "*#{@name}*'s health is already full."
        elsif @health < 1 then
            return "*#{@name}* is dead."
        end

        @health += amount
        if @health > 15 then
            @health = 15
        end
        save_to_memory('health', @health) # really i have to merge these, i don't like having to do two steps here

        "I healed *#{@name}* up to *" + @health.to_s + 'hp*!'
    end

    def damage(amount)
        if @health - amount > 0 then
          @health -= amount
        else
          @health = 0
        end

        save_to_memory('health', @health)
    end

    def raise
        if @health > 0 then
            return "*#{@name}* is not dead."
        end

        @health = 5
        save_to_memory('health', @health) # again with the two-calls

        "I raised *#{@name}* back to life with *5hp*!"
    end

    def change_profession(new_profession)
        all_professions = @@all_professions.keys

        current_profession = @profession

        unless all_professions.include?(new_profession) then
            professionsString = ''
            all_professions.each do |profession|
                professionsString += '`' + profession + '` '
            end
            return "You need to select a proper profession among these:.\n" + professionsString
        end

        if current_profession == new_profession then
           return "#{@name}, you already are a *#{new_profession}*."
        end

        @profession = new_profession # and again
        save_to_memory('profession', @profession)

        "#{@name} has changed profession from *#{current_profession}* to *#{new_profession}*."
    end
end
