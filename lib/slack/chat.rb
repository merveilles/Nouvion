module Slack::Chat
    def self.post_message(channel, text, options = nil)
        uri = URI.join(Slack.base_url, 'chat.postMessage')

        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(uri.path)

        params = {
            'token' => Slack.token,
            'channel' => channel,
            'text' => text,
            'username' => 'Nouvion',
            'as_user' => 'true'
        }

        request.body = URI.encode_www_form(params)

        response = https.request(request)

        return JSON.parse(response.body)
    end
end
