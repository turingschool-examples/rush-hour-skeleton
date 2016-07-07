require 'json'
require 'useragent'

module DataProcessor
  def parse_it(request)
    JSON.parse("#{request}")
  end

  def process_payload(request)
    data = parse_it(request)
    formatted = assign_data(data)
    url = assign_data_to_url(formatted)
    refer = assign_data_to_referred_by(formatted)
    type = assign_data_to_request_type(formatted)
    agent = assign_data_to_user_agent(formatted)
    res = assign_data_to_resolution(formatted)
    ip = assign_data_to_ip(formatted)
    PayloadRequest.create({:requested_at => formatted[:requested_at],
                          :responded_in => formatted[:responded_in],
                          :url_id => url,
                          :request_type_id => type,
                          :resolution_id => res,
                          :ip_id => ip,
                          :u_agent_id => agent,
                          :referred_by_id => refer})

  end

  def valid_columns
    {"url" => :url, "requestedAt" => :requested_at,
     "respondedIn" => :responded_in, "referredBy" => :referred_by,
     "requestType" => :request_type, "userAgent" => :user_agent,
     "resolutionWidth" => :resolution_width,
     "resolutionHeight" => :resolution_height, "ip" => :ip}
  end

  def assign_data(data)
    data.map do |key, value|
      [valid_columns[key], value]
    end.to_h
  end

  def assign_url_data(data)
    url = data[:url]
    split = url.split('/')
    if split.last.include?('.')
      root = split.join('/')
      path = '/'
    else
      root = split[0...split.count-1].join('/')
      path = "/#{split.last}"
    end
    {:root => root, :path => path}
  end

  def assign_data_to_url(data)
    url_data = assign_url_data(data)
    url = Url.create(root_url: url_data[:root], path: url_data[:path])
    url.id
  end

  def assign_data_to_referred_by(data)
    url_data = assign_url_data(data)
    refer = ReferredBy.create(root_url: url_data[:root], path: url_data[:path])
    refer.id
  end

  def assign_data_to_request_type(data)
    type = RequestType.create(name: data[:request_type])
    type.id
  end

  def assign_data_to_user_agent(data)
    agent = UserAgent.parse(data[:user_agent])
    u_agent = UAgent.create(browser: agent.browser, operating_system: agent.platform)
    u_agent.id
  end

  def assign_data_to_resolution(data)
    res = Resolution.create(width: data[:resolution_width], height: data[:resolution_height])
    res.id
  end

  def assign_data_to_ip(data)
    ip = Ip.create(address: data[:ip])
    ip.id
  end

end
