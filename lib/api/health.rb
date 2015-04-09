# encoding: utf-8

require "api/memory"

module API
    class Health

        def initialize(username, memory = nil)
            @username = username
            @memory = memory == nil ? API::Memory.new() : memory

            @memory.connect
        end

        def usage
            return "<USAGE GOES HERE>"
        end

        def check
            health = get_health

            return health
        end

        def update(value)
            set_health(value)
        end

        private

        def get_health
            result = @memory.load("health #{@username}")

            return result[0][2].to_i
        end

        def set_health(value)
            @memory.save("ludivine", "health #{@username}", value)
        end
    end
end
