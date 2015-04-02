#!/bin/env ruby
# encoding: utf-8

require 'net/http'
require 'json'

class Answer

	def say
		if @username == "slackbot" then return Hash["text" => "Stop messing with me..."] end

		cleanMessage = @message.sub("say ", "").strip()

		if cleanMessage.include? "in channel"
			parts = cleanMessage.split("in channel")
			channel = parts[1].strip()
			cleanMessage = parts[0].strip()

			url = URI.parse("https://hooks.slack.com/services/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")
			params = {:payload => {:text => cleanMessage, :channel => channel}}
			resp = Net::HTTP.post_form(url, params)
			puts resp.inspect
			puts data.inspect

		else

			return Hash["text" => cleanMessage]
		end
	end

end