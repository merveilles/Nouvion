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

        details = @memory.load("roulette ")
        gun_bullets = 0
        cylinder_pos = 0
        chambers = {0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0}
        details.each do |known|
            if known[1].include? "bullets" then puts gun_bullets = known[2].to_i end
            if known[1].include? "chamber" then 
                chamber = known[1].split("-")[1].to_i
                chambers[chamber] = known[2].to_i
            end
            if known[1].include? "position" then puts cylinder_pos = known[2].to_i end
        end

        bullets = parts[1].to_i 
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
        thrown_bullets = 0
        if new_bullets > 6 then 
            thrown_bullets = new_bullets - 6
            new_bullets = 6 
        end
        # save new amount of bullets
        @memory.save("ludivine", "roulette bullets", new_bullets.to_s)

        # format the response
        response = "#{@username} loads #{bullets-thrown_bullets} bullets into the revolver"
        # only one bullet => change the text to reflect
        if bullets - thrown_bullets == 1 then
            response.gsub!("bullets", "bullet")
        end

        # add nice detail
        if thrown_bullets > 0 then
            response << ", and throws away #{thrown_bullets}"
        end

        response << "."
        if new_bullets >= 6 then
            response << " It is fully loaded."
        end

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

        @memory.save("ludivine", "roulette position", cylinder_pos.to_s)
        return response
    end

    def spin
        @memory.connect()
        # randomize position of cylinder
        new_pos = rand(6)
        @memory.save("ludivine", "roulette position", new_pos.to_s)
        return "#{@username} spins the cylinder."
    end

    def pull
        @memory.connect()
        details = @memory.load("roulette ")
        gun_bullets = 0
        cylinder_pos = 0
        chambers = {0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0}
        details.each do |known|
            if known[1].include? "bullets" then puts gun_bullets = known[2].to_i end
            if known[1].include? "chamber" then 
                # get the chamber number
                chamber = known[1].split("-")[1].to_i
                # fill it up (with nothingness or with a bullet)
                chambers[chamber] = known[2].to_i
            end
            if known[1].include? "position" then puts cylinder_pos = known[2].to_i end
        end

        # 6.times do |time| puts time.to_s + ":" + chambers[time].to_s end

        response = "#{@username} pulls the trigger..."
        # check if bullet in chamber
        if chambers[cylinder_pos] == 1 then
            # fire the chamber and increment to the next
            @memory.save("ludivine", "roulette chamber-#{cylinder_pos}", "0")
            @memory.save("ludivine", "roulette position", ((cylinder_pos + 1) % 6).to_s)
            @memory.save("ludivine", "roulette bullets", (gun_bullets - 1).to_s)
            return response << " *BANG* #{@username} shot themselves."
        end
        return response << " *Click* Nothing."
    end
end
