class Answer
    def highfive
        if @username.nil?
            return 'Huh?'
        elsif @username.downcase == 'preston' || @username.downcase == 'dx' || @username.downcase == 'poka' || @username.downcase == 'xoorath' # it's because I care <3 - xoorath // I <3 u too - poka
            return mean_things(@username)
        end

        return nice_things(@username)
    end

    def nice_things(name)
        return [
            "*High fives <@#{name}>*",
            '*High fives*',
            ":xoka: <@#{name}> *high fives*",
            "Looking sharp, <@#{name}>. *high fives*",
            "You're one classy bitch, <@#{name}>. *high fives*",
            "Keep it real, <@#{name}>. *high fives*"
        ].sample
    end

    def mean_things(name)
        [
            'Uhhh, maybe later?',
            "Ohhh, heeeey. It's you. Heeeey... another time? :D",
            '...',
            "Come on <@#{name}> ... :smirk:",
            "<@#{name}>? Riiiight. How about next time?",
            "Oh, uh hello <@#{name}>. Wasn't expecting you..."
        ].sample
    end
end
