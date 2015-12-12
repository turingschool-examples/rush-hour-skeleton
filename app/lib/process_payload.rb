module TrafficSpy
  class ProcessPayload
    attr_reader :payload, :app

    def initialize(params, id)
      @payload = params
      @app = TrafficSpy::Application.find_by(identifier: id)
    end

    def process
      if app.nil?
        [403, "Identifier not registered"]
      elsif payload.nil?
        [400, "Payload can't be blank"]
      else
        save_payload
      end
    end

    def save_payload
      parsed_string = TrafficSpy::ProcessRequestParser.new.parse_request(payload)

      data = TrafficSpy::DataLoader.new(parsed_string).find_ids
      data[:application_id] = app.id

      new_payload = TrafficSpy::Payload.new(data)

      if new_payload.save
        [200, ""]
      else
        [403, "Already received request"]
      end
    end
  end
end
