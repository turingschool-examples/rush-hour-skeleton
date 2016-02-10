class PayloadParser
  # attr_reader :data
  #
  # def initialize(data)
  #   @data = data
  # end

  def self.parse(data)
    ({
      url: Url.find_or_create_by(address: data[:url]),
      requested_at: data[:requestedAt],
      responded_in: data[:respondedIn],
      referrer: Referrer.find_or_create_by(address: data[:referredBy]),
      request: Request.find_or_create_by(verb: data[:requestType]),
      event: Event.find_or_create_by(name: data[:eventName]),
      user_agent: UserAgent.find_or_create_by(browser: "Chrome", platform: "Macintosh"),
      resolution: Resolution.find_or_create_by(width: "1920", height: "1280"),
      ip: Ip.find_or_create_by(address: "63.29.38.211")
    })
  end



end
