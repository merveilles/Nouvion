# encoding: utf-8

module API::Goat
    class Thrower
        def initialize(username)
            @username = username
        end

        def throw
            if rand(110) == 0
                outcome = rand(2)

                if outcome == 0
                    return "@#{@username}: The goat thrower engulfs you in a billowing wave of goat. Goats swim over your body as they reduce your flesh to a blackened pile of goat feces."
                else
                    return "@#{@username}: The goat thrower issues a stream of goats out onto the bushlands. The goats spread all over the forest, causing an irreversable reduction in biodiversity."
                end
            else
                distance = 1 + rand(100)
                num_goats = 1 + rand(5)
                judgement = ''

                if distance < 25
                    judgement = 'Fucking awful.'
                elsif distance < 50
                    judgement = 'Try to do better next time.'
                elsif distance < 75
                    judgement = "Not bad. I've seen better."
                elsif distance < 100
                    judgement = 'Nice throw, idiot. Why are you throwing goats?'
                else
                    judgement = 'Calm down, kingpin.'
                end

                return "@#{@username}: You manage to heave #{num_goats} goats for #{distance}M. #{judgement}"
            end
        end
    end
end
