#!/bin/env ruby
# encoding: utf-8

class Answer

    # Available: moduleName,methodName,username,message

    def help

        return "I am bot created in *Ruby* by the Merveilles community, in the <#the-artificial-lounge>. You can ask me for <help> or improve my responses by creating pull requests on Github: https://github.com/merveilles/ludivine"

    end

    def channels

        return "<#the-studio> Audio Channel\n<#the-observatory> Visual Channel\n<#the-atheneum> Code Channel\n<#the-workshop> Project Channel"

    end

    def modules

        visible_modules = ""

        Dir.entries(".").each do |name,v|
            if !name.include?("module.") then next end

            visible_modules += "`" + name.sub("module.", "").sub(".rb", "")+ "` "
        end

        return "My current active modules are:\n#{visible_modules.rstrip}."

    end

end
