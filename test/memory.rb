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
            [ "", "javascript", "programming language" ],
            [ "", "beer", "alcohol" ]
        ]

    end

end
