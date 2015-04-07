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
        return "A game of russian roulette. Actions: roulette load 1..6 bullets, roulette spin, roulette pull."
    end

    def load
        @memory.connect()
        action = @message.gsub("roulette", "").strip
        parts = action.split(" ")
        gun_bullets = @memory.load("roulette bullets")
        if gun_bullets != nil and gun_bullets[2] != nil then
            gun_bullets = gun_bullets[2].to_i
        else gun_bullets = 0 end
        gun_chambers = @memory.load("roulette chamber-")
        cylinder_pos = @memory.load("roulette position")
        if cylinder_pos != nil and cylinder_pos[2] != nil then
            cylinder_pos = cylinder_pos[2].to_i
        else cylinder_pos = 0 end
      
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
        @memory.save("ludivine", "roulette bullets", new_bullets.to_s)

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
        @memory.save("ludivine", "roulette bullets", bullets.to_s)
        return response
    end

    def spin
        @memory.connect()
        # randomize position of cylinder
        new_pos = rand(6)
        @memory.save("ludivine", "roulette position", new_pos.to_s)
        return "You spin the cylinder."
    end

    def pull
        @memory.connect()
        gun_chambers = @memory.load("roulette chamber-")
        cylinder_pos = @memory.load("roulette position")
        if cylinder_pos != nil and cylinder_pos[2] != nil then
            cylinder_pos = cylinder_pos[2].to_i
        else cylinder_pos = 0 end
      
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

        # check if bullet in chamber
        if chambers[cylinder_pos] == 1 then
            # fire the chamber and increment to the next
            @memory.save("ludivine", "roulette chamber-#{chamber}", "0")
            @memory.save("ludivine", "roulette position", ((cylinder_pos + 1) % 6).to_s)
            @memory.save("ludivine", "roulette bullets", (gun_bullets - 1).to_s)
            return "*BANG!*"
        end
        return "No bullet."
    end
end
