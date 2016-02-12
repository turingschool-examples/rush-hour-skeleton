require 'useragent'
require 'pry'

class RequestParser
  attr_accessor :request

  def self.parse_request(request)
    request = JSON.parse(request)

    url_addy = Url.find_or_create_by(address: request["url"])
    ref = ReferrerUrl.find_or_create_by(url_address: request["referredBy"])
    req = RequestType.find_or_create_by(verb: request["requestType"])
    event = EventName.find_or_create_by(event_name: request["eventName"])
    sys = UserSystem.where(browser_type: UserAgent.parse(request["userAgent"]).browser, operating_system: UserAgent.parse(request["userAgent"]).platform ).first_or_create
    res = Resolution.where(width: request["resolutionWidth"], height: request["resolutionHeight"]).first_or_create
    ip_addy = Ip.find_or_create_by(ip_address: request["ip"])

    PayloadRequest.create(url_id: url_addy.id,
                          requested_at: request["requestedAt"],
                          responded_in: request["respondedIn"],
                          referrer_url_id: ref.id,
                          request_type_id: req.id,
                          parameters: request["parameters"],
                          event_name_id: event.id,
                          user_system_id: sys.id,
                          resolution_id: res.id,
                          ip_id: ip_addy.id
                          )
  end
end
    # browse = Url.find_or_create_by(address: request["userAgent"])
    # os = Url.find_or_create_by(address: request["userAgent"])
    # uafull = request["userAgent"]
    # uaparsed = UserAgent.parse(uafull)
    # :user_agent => UserAgent.parse(request["userAgent"]).platform
# binding.pry

#Json.parse
    # parsed_request = {
    #   #### url = Url.find_or_create_by(address: request["url"])
    #   #### url = Url.where(address: request["url"]).first_or_create
    #   #### PayloadRequest.create(responded_in: request["respondedIn"],
    #                             #requested_at: request["requestedAt"],
    #                             #url_id: url.id)
    #   :url => request["url"],
    #   :requested_at => request["requestedAt"],
    #   :responded_in => request["respondedIn"],
    #   :referred_by => request["referredBy"],
    #   :request_type => request["requestType"],
    #   :parameters => request["parameters"],
    #   :event_name => request["eventName"],
    #   # :user_agent => uaparsed.browser,
    #   :resolution_width => request["resolutionWidth"],
    #   :resolution_height => request["resolutionHeight"],
    #   :ip => request["ip"]
    # }
    # PayloadRequest.create(parsed_request)

# def parse_request(string)
#   parsed_request = JSON.parse(string)
#
#   user_agent_string = parsed_request["userAgent"]
#   user_agent = UserAgent.parse(user_agent_string)
#
#   url = parsed_request["url"]
#   uri = URI(url)
#
#   {
#     :relative_path_string => uri.path,
#     :requested_at => parsed_request["requestedAt"],
#     :responded_in => parsed_request["respondedIn"],
#     :referred_by => parsed_request["referredBy"],
#     :request_type_string => parsed_request["requestType"],
#     :event_string => parsed_request["eventName"],
#     :operating_system_string => user_agent.platform,
#     :browser_string => user_agent.browser,
#     :resolution_string => {:width => parsed_request["resolutionWidth"],
#                            :height => parsed_request["resolutionHeight"]},
#     :ip_address => parsed_request["ip"]
#   }
