require_relative "source"
require 'json'

class PayloadCreator
  attr_reader :status, :body

  def result(params, identifier)
    if Source.all.none? { |s| s.identifier == identifier }
      @status = 403
      @body = "Unregistered source"
      return
    end

    if params[:payload].nil?
      @status = 400
      @body = "Missing payload data"
      return
    end

    payload_data = JSON.parse(params[:payload])
    payload = Payload.new(requested_at: payload_data["requestedAt"])
    if payload.save
      @status = 200
    else
      @status = 403
      @body = "Already received payload"
    end
  end
end
