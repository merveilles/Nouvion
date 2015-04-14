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

        def loosely_recall(term)
            return @memory.load_similar(term)
        end        

        # can't figure out a better name for that... 'search' and 'find' are equally vague
        def recall_by_definition(definition)
            return @memory.load_by_definition(term)
        end        
    end
end
