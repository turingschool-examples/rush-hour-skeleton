require 'useragent'
require 'pry'

class RequestParser

  def self.parse_request(client_payload, identifier)
    @request = JSON.parse(client_payload)

    sha = Digest::SHA1.hexdigest("#{@request}")

    if PayloadRequest.pluck(:unique_sha).include?(sha)
      return [403, "Error, Payload Already Received"]
    end

    if !Client.pluck(:identifier).include?(identifier)
      return [403, "Client is not registered"]
    end

    payload = PayloadRequest.create(url_id: url_addy.id,
                          requested_at: @request["requestedAt"],
                          responded_in: @request["respondedIn"],
                          referrer_url_id: ref.id,
                          request_type_id: req.id,
                          parameters: @request["parameters"],
                          event_name_id: event.id,
                          user_system_id: sys.id,
                          resolution_id: res.id,
                          ip_id: ip_addy.id,
                          client_id: client(identifier).id,
                          unique_sha: sha
                          )
    if payload.save
      return [200, "Payload Received"]
    elsif payload.id.nil?
      return [400, "Missing Payload"]
    end
  end

  def self.url_addy
    Url.where(address: @request["url"]).first_or_create
  end

  def self.ref
    ReferrerUrl.where(url_address: @request["referredBy"]).first_or_create
  end

  def self.req
    RequestType.where(verb: @request["requestType"]).first_or_create
  end

  def self.event
    EventName.where(event_name: @request["eventName"]).first_or_create
  end

  def self.sys
    UserSystem.where(browser_type: UserAgent.parse(@request["userAgent"]).browser, operating_system: UserAgent.parse(@request["userAgent"]).platform ).first_or_create
  end

  def self.res
    Resolution.where(width: @request["resolutionWidth"], height: @request["resolutionHeight"]).first_or_create
  end

  def self.ip_addy
    Ip.where(ip_address: @request["ip"]).first_or_create
  end

  def self.client(identifier)
    Client.where(identifier: identifier).first_or_create
  end
end
