#!/bin/env ruby
# encoding: utf-8

class Answer

    # Available: moduleName,methodName,username,message

    def help

        visibleModules = ""

        Dir.entries(".").each do |name,v|
            if !name.include?("module.") then next end
            visibleModules += "`"+name.sub("module.","").sub(".rb","")+"` "
        end

        return Hash["text" => "My current active modules are: "+visibleModules+"."]

    end

end
