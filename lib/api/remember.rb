require 'api/memory/memory_remember'

module API
    class Remember
        def initialize(username, memory = nil)
            @username = username
            @memory = memory == nil ? API::MemoryRemember.new : memory
        end

        def store(term, definition, relation)
            @memory.save(@username, term, definition, relation)
        end

        def recall(term)
            return @memory.load(term)
        end
    end
end
