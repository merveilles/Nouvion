# encoding: utf-8

module API
    class Roulette
        include API::Memory

        EMPTY = [0, 0, 0, 0, 0, 0]

        def initialize(username, memory = nil)
            @username = username

            @memory.connect()

            @chamber = EMPTY
        end

        def usage
            return "A game of russian roulette.\n`load` `spin` `pull`"
        end

        def load_revolver
            if @chamber.include?(1)
                return "@#{@username}: There is already a bullet in the revolver."
            end

            @chamber = [1, 0, 0, 0, 0, 0].shuffle

            save_memory

            return "@#{@username}: You put a bullet in the revolver. :japanese_ogre:"
        end

        def spin_cylinder
            @chamber.shuffle!

            save_memory

            return "#{@username} spins the cylinder. :return:"
        end

        def check_bullets

        end

        def pull_trigger
            if @chamber[0] == 1
                @chamber = EMPTY

                return "You pull the trigger, the gun goes.. *POW*! :finnadie::collision::gun:\nYou shot yourself in the face and died.."
            end

            if @chamber.eql?(EMPTY) == 0
                return "You pull the trigger, the gun goes.. *click*! :relaxed:\nThe gun is empty, you should `load` it."
            end

            @chamber.rotate!

            return "You pull the trigger, the gun goes.. *click*! :godmode:\nYou survived."
        end

        private

        def load_memory

        end

        def save_memory

        end
    end
end
