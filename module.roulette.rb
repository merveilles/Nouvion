#!/bin/env ruby
# encoding: utf-8

# load
# spin
# pull trigger
class Answer
    # cylinder position
    # bullet in each position
    # amt. of bullets in revolver
    def roulette
        action = @message.gsub("roulette", "").strip

        gun_bullets = @memory.load("roulette bullets")[2].to_i
        gun_bullets ||= 0
        gun_chambers = @memory.load("roulette chamber-")
        cylinder_pos = @memory.load("roulette position")[2].to_i
        cylinder_pos ||= 0
      
        chambers = {0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0}
        # load the chambers from the db
        gun_chambers.each do |part|
            if part[1] != nil then
                # get the chamber number
                chamber = part[1].split("-")[1].to_i
                if part[2] != nil then
                    chambers[chamber] = part[2].to_i
                else 
                    chambers[chamber] = 0
                end
            end
        end

        if action == "" then
            return "A game of russian roulette. Actions: roulette load 1..6 bullets, roulette spin, roulette pull."
        elsif action.include? "load"
            parts = action.split(" ")

            bullets = parts[2].to_i 
            if bullets == 0 then 
                return "You need bullets to load a revolver.."
            elsif bullets > 6 then
                return "The revolver has 6 chambers, not #{bullets}.."
            elsif bullets < 0 then
                return ".."
            elsif gun_bullets == 6 then
                return "The revolver is already fully loaded."
            end

            new_bullets = bullets + gun_bullets
            if new_bullets > 6 then new_bullets = 6 end
            # save new bullet amount
            @memory.save("ludivine", "roulette bullets", new_bullets)

            6.times do
                # chamber already has a bullet; go to the next one
                if chambers[cylinder_pos] == 1 then next end
                # load a bullet
                @memory.save("ludivine", "roulette chamber-#{cylinder_pos}", "1")
                cylinder_pos = (cylinder_pos + 1) % 6
                bullets = bullets - 1
                # we're out of bullets
                if bullets == 0 then break end
            end

            response = "You load #{bullets} bullets into the revolver."
            if new_bullets >= 6 then
                response << " It is fully loaded."
            end
            @memory.save("ludivine", "roulette chamber-#{chamber}", "1")
            @memory.save("ludivine", "roulette bullets", bullets)
            return response
        elsif action.include? "spin"
            # randomize position of cylinder
            new_pos = rand(6)
            @memory.save("ludivine", "roulette position", new_pos)
            return "You spin the cylinder."
        elsif action.include? "pull"
            # check if bullet in chamber
            if chambers[cylinder_pos] == 1 then
                # fire the chamber and increment to the next
                @memory.save("ludivine", "roulette chamber-#{chamber}", "0")
                @memory.save("ludivine", "roulette position", (cylinder_pos + 1) % 6)
                @memory.save("ludivine", "roulette bullets", gun_bullets - 1)
                return "*BANG!*"
            end
            return "No bullet."
        end
    end
end
