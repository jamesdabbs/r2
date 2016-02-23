class Slack
  def initialize
    @endpoint = URI.parse Figaro.env.SLACK_WEBHOOK_URL!
  end

  def notify opts
    opts[:username]  = "15PBot"
    opts[:channel] ||= "#15th-and-p"

    Net::HTTP.post_form @endpoint, payload: opts.to_json
  end
end
