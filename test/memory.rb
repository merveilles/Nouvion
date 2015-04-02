class Memory

    def connect

    end

    def load(username)
        return []
    end

end

class MemoryTest < Memory

    def load(topic)

        return [
            [ "ludivine", "javascript", "programming language" ],
            [ "ludivine", "beer", "alcohol" ],
            [ "ludivine", "win", "for the win" ]
        ]

    end

end
