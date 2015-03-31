#!/bin/env ruby
# encoding: utf-8

class Answer

    # Available: moduleName,methodName,username,message

    def calc # ludivine calc 1 + 2

        oper = @message.split(" ")[0]
        val1 = @message.split(" ")[1].to_i
        val2 = @message.split(" ")[2].to_i

        return Hash["text" => "Module by Aliceffekt."]

    end

    def add

        val1 = @message.split(" ")[2].to_i
        val2 = @message.split(" ")[3].to_i

        return Hash["text" => "The sum of #{val1} and #{val2}, is "+(val1+val2).to_s+"."]

    end

    def subtract

        val1 = @message.split(" ")[2].to_i
        val2 = @message.split(" ")[3].to_i

        return Hash["text" => "The result of #{val2} subtracted to #{val1}, is "+(val1-val2).to_s+"."]

    end

    def multiply

        val1 = @message.split(" ")[2].to_i
        val2 = @message.split(" ")[3].to_i

        return Hash["text" => "The result of #{val1} multiplied by #{val2}, is "+(val1*val2).to_s+"."]

    end

    def divide

        val1 = @message.split(" ")[2].to_i
        val2 = @message.split(" ")[3].to_i

        return Hash["text" => "The result of #{val1} divided by #{val2}, is "+(val1.to_f/val2.to_f).to_s+"."]

    end

end