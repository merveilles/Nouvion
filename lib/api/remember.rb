module API
    class Remember
        def initialize(username, memory = nil)
            @username = username
            @memory = memory == nil ? API::MemoryRemember.new : memory
        end

        def store(term, definition, relation)
            if @memory.exists(@username, term)
                @memory.update(@username, term, definition, relation)
            else
                @memory.add(@username, term, definition, relation)
            end
        end

        def recall(term)
            return @memory.load(term)
        end
    end
end
