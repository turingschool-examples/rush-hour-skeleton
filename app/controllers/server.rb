module RushHour
  class Server < Sinatra::Base
    attr_reader :params,
                :parameters,
                :messages,
                :exists

    not_found do
      erb :error
    end

    post '/sources' do
      @params = params
      @parameters = client_params
      @messages = client_messages
      @exists = client_exists?
      response = params_valid? ? check_if_exists : bad_request
      status response[:status_msg]
      body response[:message]
    end

    post '/sources/:identifier/data' do
      @params = params
      @parameters = payload_params
      @messages = payload_messages
      @exists = payload_request_exists?
      response = params_valid? ? check_if_exists : bad_request
      # puts "\n\n\n******************************\n\n\n"
      # count = PayloadRequest.all.count
      # puts "\n\n\n******************************\n\n\n"
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
      return parameters.none? { |param| params[param].nil? }
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
      [:url, :requestedAt, :respondedIn, :referredBy, :requestType,
       :userAgent, :resolutionWidth, :resolutionHeight, :ip]
    end

    def client_exists?
      !(Client.find_by identifier: params[:identifier]).nil?
    end

    def payload_request_exists?
      # !(PayloadRequest.find_by identifier: params[:identifier]).nil?
      # !(PayloadRequest.where(...))
    end
  end
end
