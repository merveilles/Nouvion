# Require the main class
require_relative '../answer'
require './memory'

# Require any modules you might need
require('../module.xenon')

# Set up the payload

class MemoryTest < Memory

    def connect

    end

    def load(query)

        return [
            [ "ludivine", "wallet aliceffekt", "10" ],
            [ "ludivine", "wallet greylion", "8" ],
            [ "ludivine", "wallet maxdeviant", "5" ],
            [ "ludivine", "wallet jean", "999" ]
        ]

    end

    def save(stuffA, stuffB, stuffC)

    end

end

answer = Answer.new("xenon", "give", "jean", "xenon give aliceffekt -5", "theartificiallounge",MemoryTest.new())

# Output the result
puts answer.give()

