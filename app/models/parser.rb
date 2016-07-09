class Parser


  # def payload_parser(params)
  #   {
  #   :url => params["url"],
  #   :requested_at => params["requestedAt"],
  #   :responded_in => params["respondedIn"],
  #   :referral => params["referredBy"],
  #   :request_type => params["requestType"],
  #   :software_agent => params["userAgent"],
  #   :resolution_width => params["resolutionWidth"],
  #   :resolution_height => params["resolutionHeight"],
  #   :ip => params["ip"]
  #   }
  # end

#modify to add referral
  def create_payload(params)
      PayloadRequest.create(
      requested_at: params['requestAt'],
      responded_in: params['respondedIn'],
      url_id: Url.find_or_create_by(address: params["url"]).id,
      ip_id: Ip.find_or_create_by(address: payload_parser(params)[:ip]).id,
      request_type_id: RequestType.find_or_create_by(verb: params["requestType"]).id,
      software_agent_id: SoftwareAgent.find_or_create_by(mesage: params["userAgent"]).id,
      resolution_id: Resolution.find_or_create_by(width: params["resolutionWidth"], height: params["resolutionHeight"]).id
      # client_id: Client.create(identifier: rand(1..1000), root_url: rand(1..1000)).id
      )
    end



end
