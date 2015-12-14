class Parser
attr_reader :payload,
            :request_hash,
            :id,
            :application_id,
            :url,
            :timestamp,
            :response_time,
            :referral,
            :verb,
            :event,
            :browser,
            :os,
            :resolution,
            :complete_data

  def initialize(params)
    @payload        = JSON.parse(params.fetch('payload','{}'))
    @request_hash   = params['payload'] && sha1(params['payload'])
    @id             = params['id']
    @application_id = get_application_id(params)
    @url            = payload['url'] && get_url
    @timestamp      = payload['requestedAt']
    @response_time  = payload['respondedIn']
    @referral       = payload['referredBy']
    @verb           = payload['requestType']
    @event          = payload['eventName']
    @browser,
    @os =           get_user_agent(payload)
    @resolution =   get_resolution(payload)
  end

  def url_id
    Url.find_by(path: url) && Url.find_by(path: url).id
  end

  def event_id
    Event.find_by(name: event) && Event.find_by(name: event).id
  end

  def get_application_id(params)
    Application.find_by(identifier: params['id']) && Application.find_by(identifier: params['id']).id
  end

  def get_url
    payload['url'].split("/").slice(3..-1).join("/")
  end

  def sha1(string)
    Digest::SHA1.hexdigest(string)
  end

  def get_resolution(payload)
    width  = payload['resolutionWidth']
    height = payload['resolutionHeight']

    width && height && "#{width}x#{height}"
  end

  def request_data
    {
      request_hash:   request_hash,
      application_id: application_id,
      url_id:         url_id,
      timestamp:      timestamp,
      response_time:  response_time,
      referral:       referral,
      verb:           verb,
      event_id:       event_id,
      browser:        browser,
      os:             os,
      resolution:     resolution
    }
  end

  def url_data
    {
      path: url
    }
  end

  def get_user_agent(payload)
    return nil unless agent = payload['userAgent']
    agent = UserAgentParser.parse(agent)
    [ agent.to_s, agent.os.to_s ]
  end
end
