require 'useragent'

class RequestParser
  attr_accessor :request

  # def initialize(request)
  #   @request = request
  # end

  def self.parse_request(request)
    # uafull = request["userAgent"]
    # uaparsed = UserAgent.parse(uafull)
    # :user_agent => UserAgent.parse(request["userAgent"]).platform
# binding.pry

#Json.parse
    parsed_request = {
      #### url = Url.find_or_create_by(address: request["url"])
      #### url = Url.where(address: request["url"]).first_or_create
      #### PayloadRequest.create(responded_in: request["respondedIn"],
                                #requested_at: request["requestedAt"],
                                #url_id: url.id)
      :url => request["url"],
      :requested_at => request["requestedAt"],
      :responded_in => request["respondedIn"],
      :referred_by => request["referredBy"],
      :request_type => request["requestType"],
      :parameters => request["parameters"],
      :event_name => request["eventName"],
      # :user_agent => uaparsed.browser,
      :resolution_width => request["resolutionWidth"],
      :resolution_height => request["resolutionHeight"],
      :ip => request["ip"]
    }
    PayloadRequest.create(parsed_request)
  end

end

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
