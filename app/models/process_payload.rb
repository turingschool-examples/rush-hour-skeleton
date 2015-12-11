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

      rel_path = TrafficSpy::RelativePath.find_or_create_by(path: parsed_string[:relative_path_string])
      req_type = TrafficSpy::RequestType.find_or_create_by(verb: parsed_string[:request_type_string])
      resolution = TrafficSpy::Resolution.find_or_create_by(width: parsed_string[:resolution_string][:width],
                                                            height: parsed_string[:resolution_string][:height])
      parsed_string[:resolution_id] = resolution.id
      parsed_string[:request_type_id] = req_type.id
      parsed_string[:relative_path_id] = rel_path.id
      parsed_string[:application_id] = app.id

      new_payload = TrafficSpy::Payload.create(parsed_string)

      if new_payload.save
        [200, ""]
      else
        [403, "Already received request"]
      end
    end
  end
end
