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
# binding.pry
    @payload        = JSON.parse(params.fetch('payload','{}'))

    @request_hash   = params['payload'] && sha1(params['payload'])
    # binding.pry
    @application_id = Application.find_by(identifier: params['id']) && Application.find_by(identifier: params['id']).id
    @id             = params['id']
    @url            = payload['url']
    @timestamp      = payload['requestedAt']
    @response_time  = payload['respondedIn']
    @referral       = payload['referredBy']
    @verb           = payload['requestType']
    @event          = payload['eventName']

    @browser,
    @os =           get_user_agent(payload)
    @resolution =   get_resolution(payload)
    #no using parameters nor ip
  end

  def sha1(string)
    Digest::SHA1.hexdigest(string)
  end

  def get_resolution(payload)
    width = payload['resolutionWidth']
    height = payload['resolutionHeight']

    width && height && "#{width}x#{height}"
  end

  def complete_data
    { request_hash: request_hash,
      application_id: application_id,
      url: url,
      timestamp: timestamp,
      response_time: response_time,
      referral: referral,
      verb: verb,
      event: event,
      browser: browser,
      os: os,
      resolution: resolution
    }
  end

  def get_user_agent(payload)
    # if agent = payload['userAgent']
    #   user_agent = UserAgentParser.parse(agent)
    #   [ user_agent.to_s, user_agent.os.to_s ]
    # end

    return nil unless agent = payload['userAgent']
    agent = UserAgentParser.parse(agent)
    [ agent.to_s, agent.os.to_s ]
  end

end
