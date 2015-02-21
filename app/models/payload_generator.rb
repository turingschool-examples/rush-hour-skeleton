require 'digest'
require 'json'
require 'useragent'

class PayloadGenerator
  attr_reader :status, :message
  def initialize(status, message)
    @status  = status
    @message = message
  end

  def self.call(params, identifier)
    source = Source.find_by(identifier: identifier)
    return PayloadGenerator.new(403, "not registered") unless source

    if params.nil? || JSON.parse(params).empty?
      PayloadGenerator.new(400, "missing payload")
    elsif Payload.find_by(digest: Digest::SHA2.hexdigest(params))
      PayloadGenerator.new(403, "duplicate request")
    else
      payload_params = JSON.parse(params).symbolize_keys
      user_agent = UserAgent.parse(payload_params[:userAgent])
      source.payloads.create({
        url_id:          Url.find_or_create_by(address: payload_params[:url]).id,
        requested_at:    payload_params[:requestedAt],
        responded_in:    payload_params[:respondedIn],
        reference_id:    Reference.find_or_create_by(
                           link: payload_params[:referredBy]).id,
        request_type_id: RequestType.find_or_create_by(
                           http_verb: payload_params[:requestType]).id,
        event_id:        Event.find_or_create_by(
                           name: payload_params[:eventName]).id,
        user_agent_id:   PayloadUserAgent.find_or_create_by(
                           browser: user_agent.browser,
                           os: user_agent.platform).id,
        resolution_id:   Resolution.find_or_create_by(
                           resolution_height: payload_params[:resolutionHeight],
                           resolution_width: payload_params[:resolutionWidth]).id,
        ip_id:           Ip.find_or_create_by(address: payload_params[:ip]).id
      })
      PayloadGenerator.new(200, "payload successful")
    end
  end
end
