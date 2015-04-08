#!/bin/env ruby
# encoding: utf-8

class Answer

	def time

        time = Time.new.strftime("%H:%M:%S")
        return "The <http://xxiivv.com|XXIIVV> server time is *#{time}*."

	end

    def day

        day = Time.new.strftime("%B %d, %Y")
        return "We are the *#{day}*."

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

        return "The XXIIVV Month is #{month}"

    end

end