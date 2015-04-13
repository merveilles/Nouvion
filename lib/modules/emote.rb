class Answer
    def emote
        smile
    end

    def smile
        oper = @message.split(' ')[0]
        val1 = @message.split(' ')[1].to_i
        val2 = @message.split(' ')[2].to_i

        eyes = ['O', 'o', '^', '*']
        mouths = ['_', '__', '.']

        symmetry = rand(1) > 0

        lefteye = eyes.sample
        righteye = lefteye

        unless symmetry
            righteye = eyes.sample
        end

        return lefteye + mouths.sample + righteye
    end

    def flip
        @flip_emojis = ['(ﾉ °□°)ﾉ︵ ┻─┻', '(ノ ゜Д゜)ノ ︵ ┻━┻', '(ﾉಥ益ಥ）ﾉ﻿ ┻━┻', "(╯'□')╯︵ ┻━┻"]

        message = @message.sub('emote flip', '').strip

        return (@flip_emojis.sample + if message.length > 0 then " *#{message}* " else '' end)
    end

    def shrug
        message = @message.sub('emote shrug', '').strip

        return (if message.length > 0 then "*#{message}* " else '' end + '¯\\_(ツ)_/¯')
    end

    def donger
        message = @message.sub('emote donger', '').strip

        message = if message.length > 0 then message else 'raise your dongers' end

        return "ヽ༼ຈل͜ຈ༽ﾉ #{message} ヽ༼ຈل͜ຈ༽ﾉ"
    end

    def molly
        message = @message.sub('emote molly', '').strip

        message = if message.length > 0 then message.upcase else 'MOLLY' end

        return "༼ つ ◕_◕ ༽つ #{message} ༼ つ ◕_◕ ༽つ"
    end
end
