class Answer
    def time
        time = Time.new.strftime("%H:%M:%S")

        return "<@#{@username}>: The server time is *#{time}*."
    end

    def day
        day = Time.new.strftime("%B %d, %Y")

        return "<@#{@username}>: Today is *#{day}*."
    end

    def month

        desamber = [
            "Monuary",
            "Dotuary",
            "Trisuary",
            "Tetruary",
            "Pentuary",
            "Hexuary",
            "Septamber",
            "Octamber",
            "Enneamber",
            "Desamber",
            "Undesamber",
            "Dodesamber"
        ]

        month = desamber[Time.now.month - 1]

        return "<@#{@username}>: The XXIIVV Month is #{month}"

    end

end
