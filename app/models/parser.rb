class Parser
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def payload_parser
      {requested_at: params['requestedAt'],
      responded_in: params['respondedIn'],
      url_id: Url.find_or_create_by(address: params["url"]).id,
      ip_id: Ip.find_or_create_by(address: params["ip"]).id,
      request_type_id: RequestType.find_or_create_by(verb: params["requestType"]).id,
      software_agent_id: SoftwareAgent.find_or_create_by(message: params["userAgent"]).id,
      resolution_id: Resolution.find_or_create_by(width: params["resolutionWidth"], height: params["resolutionHeight"]).id,
      referral_id: Referral.find_or_create_by(address: params["referredBy"]).id}
  end



end
