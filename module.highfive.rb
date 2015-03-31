#!/bin/env ruby
# encoding: utf-8

class Answer
      def me
            if @username == nil
                  return Hash["text" => "Huh?"]
            end
            if @username.downcase == 'preston' or @username.downcase == 'dx' or @username.downcase == 'poka' # it's because I care <3 - xoorath
                  return Hash["text" => meanthings(@username)]
            end
            return Hash["text" => nicethings(@username)]
      end
      def nicethings(name)
            return ["**High fives " + name + "**",
            "**High fives**",
            ":xoka: " + name + " **high fives**",
            "Looking sharp, " + name + ". **high fives**",
            "You're one classy bitch, " + name + ". **high fives**",
            "Keep it real, " + name + ". **high fives**"].shuffle[0]
      end
      def meanthings(name)
            return ["Uhhh, maybe later?",
            "Ohhh, heeeey. It's you. Heeeey... another time? :D",
            "...",
            "Come on " + name + " ... :smirk:",
            name + "? Riiiight. How about next time?",
            "Oh, uh hello " + name + ". Wasn't expecting you..."].shuffle[0]
      end
end