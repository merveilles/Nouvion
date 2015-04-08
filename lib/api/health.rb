# encoding: utf-8

module API
    class Health
        include API::Memory

        def initialize(username, memory = nil)
            @username = username
            @memory = memory == nil ? Memory.new() : memory
        end

        def usage
            return "<USAGE GOES HERE>"
        end

        def check
            health = load_memory

            return health
        end

        private

        def load_memory
            @memory.connect

            thoughts = @memory.load("health #{@username}")

            return thoughts[0][2].to_i
        end

        def save_memory

        end
    end
end
