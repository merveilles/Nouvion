module Slack::RTM
    def self.start
        uri = URI.join(Slack.base_url, 'rtm.start')

        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(uri.path)

        params = {
            'token' => Slack.token
        }

        request.body = URI.encode_www_form(params)

        response = https.request(request)

        return JSON.parse(response.body)
    end
end
