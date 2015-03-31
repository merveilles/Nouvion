#!/bin/env ruby
# encoding: utf-8

class Answer

    # Available: moduleName,methodName,username,message

    def help

        return Hash["text" => "I am bot created in *Ruby* by the Merveilles community. I can only take alphaNumeric commands. You can improve my responses by creating pull requests on Github: https://github.com/merveilles/ludivine"]        

    end

    def modules

        visibleModules = ""

        Dir.entries(".").each do |name,v|
            if !name.include?("module.") then next end
            visibleModules += "`"+name.sub("module.","").sub(".rb","")+"` "
        end

        return Hash["text" => "My current active modules are: "+visibleModules+"."]

    end

end
