class Answer
    def calc
        "My calc module requires a method from this list:\n`add` `subtract` `multiply` `divide`."
    end

    def add
        val1 = @message.split(' ')[2].to_i
        val2 = @message.split(' ')[3].to_i

        sum = (val1 + val2).to_s

        "The sum of #{val1} and #{val2}, is #{sum}."
    end

    def subtract
        val1 = @message.split(' ')[2].to_i
        val2 = @message.split(' ')[3].to_i

        difference = (val1 - val2).to_s

        "The difference of #{val2} subtracted from #{val1}, is #{difference}."
    end

    def multiply
        val1 = @message.split(' ')[2].to_i
        val2 = @message.split(' ')[3].to_i

        product = (val1 * val2).to_s

        "The product of #{val1} and #{val2}, is #{product}."
    end

    def divide
        val1 = @message.split(' ')[2].to_i
        val2 = @message.split(' ')[3].to_i

        dividend = (val1.to_f / val2.to_f).to_s

        "The dividend of #{val1} divided by #{val2}, is #{dividend}."
    end
end
