require 'json'
require 'useragent'
require 'uri'

module Processor
extend self

  def clean_data(params)
    {identifier: params[:identifier], root_url: params[:rootUrl]}
  end

  def json_parser(params)
    JSON.parse(params)
  end

  def params_cleaner(params)
    user_agent, referredby, url = params_parser(params)

    {
     requested_at: json_parser(params)['requestedAt'],
     responded_in: json_parser(params)['respondedIn'],
     referred_by_id: ReferredBy.find_or_create_by(root_url: referredby.host, path: referredby.path).id,
     request_type_id: RequestType.find_or_create_by(http_verb: json_parser(params)['requestType']).id,
     event_id: Event.find_or_create_by(event_name: json_parser(params)['eventName']).id,
     agent_id: Agent.find_or_create_by(browser: user_agent.browser, operating_system: user_agent.platform).id,
     resolution_id: Resolution.find_or_create_by(height: json_parser(params)['resolutionHeight'], width: json_parser(params)['resolutionWidth']).id,
     ip_id: Ip.find_or_create_by(address: json_parser(params)['ip']).id,
     url_id: Url.find_or_create_by(root_url: url.host, path: url.path).id
    }
  end

  def does_payload_exist?(params, client)
    user_agent, referredby, url = params_parser(params)

    Payload.find_by(
       requested_at: json_parser(params)['requestedAt'],
       responded_in: json_parser(params)['respondedIn'],
       referred_by: ReferredBy.find_by(root_url: referredby.host, path: referredby.path),
       request_type: RequestType.find_by(http_verb: json_parser(params)['requestType']),
       event: Event.find_by(event_name: json_parser(params)['eventName']),
       agent: Agent.find_by(browser: user_agent.browser, operating_system: user_agent.platform),
       resolution: Resolution.find_by(height: json_parser(params)['resolutionHeight'], width: json_parser(params)['resolutionWidth']),
       ip: Ip.find_by(address: json_parser(params)['ip']),
       url: Url.find_by(root_url: url.host, path: url.path)
     )
  end

  def params_parser(params)
    user_agent = UserAgent.parse(json_parser(params)['userAgent'])
    referredby = URI.parse(json_parser(params)['referredBy'])
    url = URI.parse(json_parser(params)['url'])

    [user_agent, referredby, url]
  end

  def get_client_stats(identifier)
    Client.find_by(identifier: identifier)
  end

  def get_url_stats(relativepath)
    Url.find_by(path: relativepath)
  end

  def get_client_events(client)
    client.event.distinct.map{|e| e.event_name}
  end

  def get_event_stats(client, eventname)
    dates = client.payload.where(event: Event.find_by(event_name: eventname))

    date_array = dates.map do |d|
      DateTime.parse(d.requested_at)
    end.map { |x| x.hour }.sort
    final_hours = (0..24).to_a - date_array

    date_hash = date_array.reduce(Hash.new(0)) {|result, e| result[e] += 1; result}
    hours_hash = final_hours.reduce({}) { |result, e|  result[e] = 0; result}
    date_hash.merge(hours_hash).sort.to_h
  end

end
