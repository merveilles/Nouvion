#!/bin/env ruby
# encoding: utf-8

class Answer

    # Available: moduleName,methodName,username,message

    #for flipping text
    T = [[65, 5572], [66, 5626], [67, 390], [68, 5601], [69, 398], [70, 8498], [71, 8513], [72, 72], [73, 73], [74, 5259], [75, 20012], [76, 8514], [77, 87], [78, 78], [79, 79], [80, 1280], [81, 908], [82, 7450], [83, 83], [84, 8869], [85, 1352], [86, 923], [87, 77], [88, 88], [89, 8516], [90, 90], [97, 592], [98, 113], [99, 596], [100, 112], [101, 601], [102, 607], [103, 595], [104, 613], [105, 7433], [106, 638], [107, 670], [108, 108], [109, 623], [110, 117], [111, 111], [112, 100], [113, 98], [114, 633], [115, 115], [116, 647], [117, 110], [118, 652], [119, 653], [120, 120], [121, 654], [122, 122], [48, 48], [49, 8642], [50, 423], [51, 949], [52, 5421], [53, 53], [54, 57], [55, 76], [56, 56], [57, 54], [46, 729], [44, 8216], [45, 45], [58, 58], [59, 1563], [33, 161], [63, 191], [38, 8523], [40, 41], [41, 40], [60, 62], [62, 60], [91, 93], [93, 91], [95, 8254], [8254, 95], [123, 125], [125, 123], [8756, 8757], [8757, 8756]]

    def emote

        return smile

    end

    #show us your true face, ludivine
    def smile

        oper = @message.split(" ")[0]
        val1 = @message.split(" ")[1].to_i
        val2 = @message.split(" ")[2].to_i

        eyes = ["O","o","^","*" ]
        mouths = ["_","__","." ]

        symmetry = rand(1) > 0

        lefteye = eyes.shuffle[0]
        righteye = lefteye
        if( !symmetry )
            righteye = eyes.shuffle[0]
        end

        text = lefteye + mouths.shuffle[0] + righteye

        return text

    end

    def flip
        message = @message.sub("emote flip", "").strip
        ret = "(╯°□°）╯︵ ┻━┻"

        if message.length >0 

            flipped_message = []

            message.each_char do |chr|
                code = T.assoc(chr.ord)
                flipped_message << code ? code[1].chr('UTF-8') : chr
            end
            flipped_message = flipped_message.join.reverse
            ret += flipped_message        
        end

        ret
    end

    def shrug

        message = @message.sub("emote shrug", "").strip

        return (if message.length > 0 then "*#{message}* " else "" end + "¯\\_(ツ)_/¯")

    end

    def donger

        message = @message.sub("emote donger", "").strip

        message = if message.length > 0 then message else "raise your dongers" end

        return "ヽ༼ຈل͜ຈ༽ﾉ #{message} ヽ༼ຈل͜ຈ༽ﾉ"

    end

    def molly

        message = @message.sub("emote molly", "").strip

        message = if message.length > 0 then message.upcase else "MOLLY" end

        return "༼ つ ◕_◕ ༽つ #{message} ༼ つ ◕_◕ ༽つ"

    end

end
