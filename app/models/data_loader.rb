class DataLoader

  def self.load(payload, identifier)
    payload = PayloadRequest.new ({

    url:              Url.find_or_create_by(address: payload["url"]),
    requested_at:     payload["requestedAt"],
    request_type:     RequestType.find_or_create_by(payload["requestType"]),
    resolution:       Resolution.find_or_create_by(height: payload["resolutionWidth"], width: payload["resolutionHeight"]),
    referrer:         Referrer.create(address: payload["referredBy"]),
    software_agent:   SoftwareAgent.create(os: payload["software_agent"].os, browser: payload["software_agent"].browser),
    ip:               Ip.create(address: payload["ip"]),
    client:           Client.find_by(identifier: identifier),
    parameter:        Parameter.find_or_create_by(user_input: payload["parameters"].to_s) })

  #   payload = PayloadRequest.find_or_create_by({
  #       :url_id => url.id,
  #       :requested_at => requested_at,
  #       :responded_in => i,
  #       :request_type_id => request_type.id,
  #       :resolution_id => resolution.id,
  #       :referred_by_id => referrer.id,
  #       :software_agent_id => software_agent.id,
  #       :ip_id => ip.id,
  #       :parameter_id => parameter.id,
  #       :client_id => client.id
    # })
  payload.save
  end
end
