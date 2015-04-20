# encoding: utf-8

module API::Goat
    class Tower
        @@outcomes = [
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
            "The poster reads: \"There is no futBAAAAAAHHHHure but what we mBAAAAHHHHHHHHke for ouBAAAAAAHHHHHHHHHHHHHrselves.\"",
            "You are ambushed by a troupe of hobgoats. Although they are small, they are very ugly and their coordinated acrobatics intimidate you.",
            "You stumble into the mead hall. The mead is delicious and hearty, with a grassy connotation on the tail. You spend a night in lively discussion with some of the most radiantly charismatic, deeply insightful goats you have ever met.",
            "You make brief eye contact with a very beautiful goat outside of the goat tower.",
            "You hide as a very fat, decadent goat sitting on a platform being carried by a number of lesser goats passes by you in the halls of the goat tower.",
            "You find the goats' repository of wizard tomes."
        ]

        def initialize(username)
            @username = username
        end

        def climb
            return "<@#{@username}>: #{@@outcomes.sample}"
        end
    end
end
