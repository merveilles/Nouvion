#!/bin/env ruby
# encoding: utf-8

class Answer
    def goat
        'What about goats?'
    end

    def tower
        tower = [
          'You die trying to reach the goat tower.',
          'You die trying to take your first step into the goat tower.',
          'You die after trying to fight with a goat from the goat tower.',
          'You die falling from the goat tower.',
          'You die by a misstep scaling the goat tower.',
          'You die by the horns of a goat halfway up the goat tower.',
          'You successfully enter the goat tower.',
          'You talk to the goat master of the goat tower. He imparts upon you great and dark goat wisdom.',
          'The goat herd attacks your girlfriend, taking her hostage and demanding the release of their imprisoned goat brothers.',
          'You learn the secrets of the goat tower.',
          'You become a goat of the goat tower.',
          'The goats of the goat tower give you a massage with their cloven hooves.',
          'You die an old man at the top of the tower, your goat herd surrounding your bed.',
          "You successfully enter the goat tower. Or do you. In patternist Tegmark-4 space you haven't truly entered anything until you've defeated 5 neoreactionaries in midi-to-midi combat.",
          'You successfully communicate with the goat imperialist. You are financially drained after being mentally frozen by his academic wisdom.',
          "The goat laughs \"BAAAHHHHHHHHHHAHAHA\" as you are forced to leap from the goat tower",
          'The scroll from the elder goat states there is a passage way with a green star engraved. You might become rich if you can find this passage.',
          "The poster reads: \"There is no futBAAAAAAHHHHure but what we mBAAAAHHHHHHHHke for ouBAAAAAAHHHHHHHHHHHHHrselves.\""
        ]

        "@#{@username}: #{tower.shuffle[0]}"
    end

    def thrower
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
