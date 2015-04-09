# encoding: utf-8

module API
    class Health

        def initialize(username, memory = nil)
            @username = username
            @memory = memory == nil ? Memory.new : memory
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

        def list
            health_list = {}

            get_health_all.each do |row|
                health_list[row[1].sub("health ", "")] = row[2].to_i
            end

            return health_list
        end

        private

        def get_health
            @memory.connect

            result = @memory.load("health #{@username}")

            return result[0][2].to_i
        end

        def get_health_all
            @memory.connect

            result = @memory.load("health ")

            return result
        end

        def set_health(value)
            @memory.connect

            @memory.save("ludivine", "health #{@username}", value)
        end
    end
end
