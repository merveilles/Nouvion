# require 'api/health'

module API
    class Roulette

        EMPTY = [0, 0, 0, 0, 0, 0]

        def initialize(username, memory = nil)
            @username = username
            @memory = memory == nil ? MemoryRoulette.new : memory

            # @health = API::Health.new(@username, @memory)

            @chamber = EMPTY
        end

        def self.usage
            return "A game of russian roulette.\n`load` `spin` `pull`"
        end

        def load_revolver
            load_state

            if @chamber.include?(1)
                return "<@#{@username}>: There is already a bullet in the revolver."
            end

            @chamber = [1, 0, 0, 0, 0, 0].shuffle

            save_state

            return "<@#{@username}>: You put a bullet in the revolver. :japanese_ogre:"
        end

        def spin_cylinder
            load_state

            @chamber.shuffle!

            save_state

            return "<@#{@username}> spins the cylinder. :return:"
        end

        def pull_trigger
            load_state

            if @chamber[0] == 1
                @chamber = EMPTY

                save_state

                # @health.update(0)

                return "<@#{@username}>: You pull the trigger, the gun goes.. *POW*! :finnadie::collision::gun:\nYou shot yourself in the face and died.."
            end

            if @chamber.eql?(EMPTY)
                return "<@#{@username}>: You pull the trigger, the gun goes.. *click*! :relaxed:\nThe gun is empty, you should `load` it."
            end

            @chamber.rotate!

            save_state

            return "<@#{@username}>: You pull the trigger, the gun goes.. *click*! :godmode:\nYou survived."
        end

        private

        def load_state
            result = @memory.load

            @chamber = result[0][1].split('').map { |v| v.to_i }
        end

        def save_state
            if @memory.exists
                @memory.update(@chamber.join(''))
            else
                @memory.add(@chamber.join(''))
            end
        end
    end
end
