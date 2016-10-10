require 'json'
require 'useragent'
require 'uri'
require 'pry'

module Processor
extend self

  def clean_data(params)
    {identifier: params[:identifier], root_url: params[:rootUrl]}
  end

  def json_parser(params)

    JSON.parse(params)
  end

  def params_cleaner(params)
    user_agent = UserAgent.parse(json_parser(params)['userAgent'])
    rb = URI.parse(json_parser(params)['referredBy'])
    u = URI.parse(json_parser(params)['url'])
    {
       requested_at: json_parser(params)['requestedAt'],
       responded_in: json_parser(params)['respondedIn'],
       referred_by_id: ReferredBy.find_or_create_by(root_url: rb.host, path: rb.path).id,
       request_type_id: RequestType.find_or_create_by(http_verb: json_parser(params)['requestType']).id,
       event_id: Event.find_or_create_by(event_name: json_parser(params)['eventName']).id,
       agent_id: Agent.find_or_create_by(browser: user_agent.browser, operating_system: user_agent.platform).id,
       resolution_id: Resolution.find_or_create_by(height: json_parser(params)['resolutionHeight'], width: json_parser(params)['resolutionWidth']).id,
       ip_id: Ip.find_or_create_by(address: json_parser(params)['ip']).id,
       url_id: Url.find_or_create_by(root_url: u.host, path: u.path).id
     }


  end

end
