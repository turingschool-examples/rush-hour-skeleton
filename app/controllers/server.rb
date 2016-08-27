module RushHour
  class Server < Sinatra::Base
    attr_reader :expected_params,
                :parameters,
                :messages,
                :exists,
                :payload_request

    not_found do
      erb :error
    end

    post '/sources' do
      @params = params
      @expected_params = client_params
      @messages = client_messages
      @exists = client_exists?
      response = params_valid? ? check_if_exists : bad_request
      status response[:status_msg]
      body response[:message]
    end

    post '/sources/:identifier/data' do
      @params = params
      @expected_params = payload_request_parameters
      @messages = payload_messages
      if !params_valid?
        response = bad_request
      elsif !payload_valid?
        response = bad_request
      else
        @payload_request = DataParser.new(params).parse_payload
        if payload_request_exists?
          response = response = {
            :status_msg => 403,
            :message => "Payload request already exists"
          }
        elsif application_request_does_not_exist?
          response = response = {
            :status_msg => 403,
            :message => "Application does not exist"
          }
        else
          PayloadRequest.create(payload_request)
          response = {
            :status_msg => 200,
            :message => "Success"
          }
        end
      end
      status response[:status_msg]
      body response[:message]
    end


    private

    def check_if_exists
      exists ? forbidden : ok
    end

    def ok
      client = Client.create("identifier" => params[:identifier],
                    "root_url" => params[:rootUrl])
      { :status_msg => 200, :message => JSON.generate({"identifier" => client.identifier}) }
    end

    def bad_request
      { :status_msg => 400, :message => messages[400] }
    end

    def forbidden
      { :status_msg => 403, :message => messages[403] }
    end

    def params_valid?
      expected_params.all? do |expected_param|
        !params[expected_param].nil? && params[expected_param] != ""
      end
    end

    def payload_valid?
      parsed_payload = JSON.parse(params["payload"])
      payload_params.all? do |payload_param|
        !parsed_payload[payload_param].nil? && parsed_payload[payload_param] != ""
      end
    end

    def client_params
      [:identifier, :rootUrl]
    end

    def client_messages
      {400 => "Parameters must include #{client_params.join(' and ')}.",
       403 => "Client already exists"}
    end

    def payload_messages
      {400 => "Parameters must include #{payload_params[0..7].join(', ')} and #{payload_params[8]}.",
       403 => "Payload request already exists"}
    end

    def payload_params
      ["url", "requestedAt", "respondedIn", "referredBy", "requestType",
       "userAgent", "resolutionWidth", "resolutionHeight", "ip"]
    end

    def payload_request_parameters
      [:payload, :identifier]
    end

    def client_exists?
      !(Client.find_by identifier: params[:identifier]).nil?
    end

    def payload_request_exists?
      pr = PayloadRequest.where(url_id: payload_request["url_id"],
                                requested_at: payload_request["requested_at"].getutc,
                                responded_in: payload_request["responded_in"],
                                source_id: payload_request["source_id"],
                                request_type_id: payload_request["request_type_id"],
                                u_agent_id: payload_request["u_agent_id"],
                                screen_resolution_id: payload_request["screen_resolution_id"],
                                ip_address_id: payload_request["ip_address_id"],
                                client_id: payload_request["client_id"])
      !pr.empty?
    end

    def application_request_does_not_exist?
      client = Client.find_by(id: payload_request["client_id"])
      client.nil?
    end
  end
end
