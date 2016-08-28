class PayloadPopulator
  def self.populate(payload, identifier)
    ip = Ip.find_or_create_by(address: payload[:ip])
    referral = Referral.find_or_create_by(referred_by: payload[:referred_by])
    request_type = RequestType.find_or_create_by(http_verb: payload[:request_type])
    resolution = Resolution.find_or_create_by(height: payload[:resolution_height], width: payload[:resolution_width])
    url = Url.find_or_create_by(web_address: payload[:url])
    system_information = SystemInformation.find_or_create_by(browser: payload[:browser], operating_system: payload[:operating_system])
    client = Client.find_by(identifier: identifier)

    payload_request = PayloadRequest.new(requested_at: payload[:requested_at],
      responded_in: payload[:responded_in],
      resolution_id: resolution.id,
      system_information_id: system_information.id,
      referral_id: referral.id,
      ip_id: ip.id,
      request_type_id: request_type.id,
      url_id: url.id,
      client_id: client.id)
  end
end
