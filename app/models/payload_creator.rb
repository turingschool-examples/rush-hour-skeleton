require_relative "source"
require 'json'

class PayloadCreator
  def initialize(params, identifier)
    @params = params
    @identifier = identifier
    payload_data = JSON.parse(@params[:payload])
    @payload = Payload.new(requested_at: payload_data["requestedAt"])
  end

  def status
    result[0]
  end

  def body
    result[1]
  end

  def registered?
    Source.exists?(identifier: @identifier)
  end

  def missing_payload?
    @params[:payload].nil?
  end

  def result
    return [403, "Unregistered source"] unless registered?
    return [400, "Missing payload data"] if missing_payload?

    if @payload.save
      [200, "OK"]
    else
      [403, "Already received payload"]
    end
  end
end
