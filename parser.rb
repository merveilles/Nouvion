begin 

require 'rubygems'
require 'json'
require 'database.rb'
require 'answer.rb'

username = ARGV[0].to_s
message  = ARGV[1].to_s.gsub("+"," ").lstrip.rstrip
channel  = ARGV[2].to_s.lstrip.rstrip

$webhookIncoming = "https://hooks.slack.com/services/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"

if message.split(" ")[0] == "ludivine" || message.split(" ")[0] == "ludivine:"
	message = message.to_s.sub("ludivine:","").sub("ludivine","").strip
end

# message  = message.gsub(":add:","+")

# Build lookup
moduleName = message.split(" ")[0].to_s.downcase
methodName = message.split(" ")[1].to_s.downcase

# Allow for Incoming API
def sayInChannel channel,message
	message = message.gsub("`","").gsub(/[^0-9a-zA-z ]/i, '')
	exec(`curl -X POST --data-urlencode 'payload={"channel": "#{channel}", "username": "Ludivine", "text": "#{message}", "icon_url": "http://core.xxiivv.com/slack/avatar.jpg"}' https://hooks.slack.com/services/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`)
end

# Create answer
answer = Answer.new(moduleName,methodName,username,message,channel)

# Load module
if File.exist?("module."+moduleName+".rb")

  require "module."+moduleName+".rb"

end

if message.to_s == ""

	puts Hash["text" => "Yes? How may I assist you #{@username}."].to_json

elsif moduleName.to_s != ""

	if methodName != ""
		if answer.respond_to?(methodName)
			puts Hash["text" => answer.send(methodName)].to_json
		elsif answer.respond_to?(moduleName)
			puts Hash["text" => answer.send(moduleName)].to_json
		else
			puts Hash["text" => answer.unknownMethod].to_json
		end
	else
		if answer.respond_to?(moduleName)
			puts Hash["text" => answer.send(moduleName)].to_json
		else
			puts Hash["text" => answer.unknownModule].to_json
		end
	end

else

	puts Hash["text" => "Huh?"].to_json

end

rescue Exception
	puts "<pre><b>Error</b>     "+$!.to_s+"<br/><b>Location</b>  "+$@.to_s+"<br /><b>Report</b>    Please, report this error to <a href='https://twitter.com/aliceffekt'>@aliceffekt</a></pre>"
end