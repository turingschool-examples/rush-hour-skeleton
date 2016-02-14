require 'useragent'
require 'pry'

class RequestParser

  def self.parse_request(request, identifier)
    request = JSON.parse(request)

    sha = Digest::SHA1.hexdigest("#{request}")

    if PayloadRequest.pluck(:unique_sha).include?(sha)
      return [403, "Error, Payload Already Received"]
    end

    if !Client.pluck(:identifier).include?(identifier)
      return [403, "Client is not registered"]
    end

    url_addy = Url.find_or_create_by(address: request["url"])
    ref = ReferrerUrl.find_or_create_by(url_address: request["referredBy"])
    req = RequestType.find_or_create_by(verb: request["requestType"])
    event = EventName.find_or_create_by(event_name: request["eventName"])
    sys = UserSystem.where(browser_type: UserAgent.parse(request["userAgent"]).browser, operating_system: UserAgent.parse(request["userAgent"]).platform ).first_or_create
    res = Resolution.where(width: request["resolutionWidth"], height: request["resolutionHeight"]).first_or_create
    ip_addy = Ip.find_or_create_by(ip_address: request["ip"])
    client = Client.find_or_create_by(identifier: identifier)

    payload = PayloadRequest.create(url_id: url_addy.id,
                          requested_at: request["requestedAt"],
                          responded_in: request["respondedIn"],
                          referrer_url_id: ref.id,
                          request_type_id: req.id,
                          parameters: request["parameters"],
                          event_name_id: event.id,
                          user_system_id: sys.id,
                          resolution_id: res.id,
                          ip_id: ip_addy.id,
                          client_id: client.id,
                          unique_sha: sha
                          )
    if payload.save
      return [200, "Payload Received"]
    elsif payload.id.nil?
      return [400, "Missing Payload"]
    end
  end
end
