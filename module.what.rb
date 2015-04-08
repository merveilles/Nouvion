class Answer

    def what

        if @message.include?("color")
            includeModule("color")
            if @message.include?("aura")  then return aura  end
            if @message.include?("today") then return today end
        end

        if @message.include?("time") || @message.include?("day")
            includeModule("time")
            if @message.include?("time")  then return time end
            if @message.include?("day")  then return day end
        end

        includeModule("define")
        return lookup

    end

end
