module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      @params = params
      response = params_valid? ? check_if_client_exists : bad_request
      count = Client.all.count
      status response[:status_msg]
      body response[:message]
    end

    private

    def check_if_client_exists
      client_exists? ? forbidden : ok
    end

    def ok
      client = Client.create("identifier" => params[:identifier],
                    "root_url" => params[:rootUrl])
      { :status_msg => 200, :message => JSON.generate({"identifier" => client.identifier}) }
    end

    def bad_request
      { :status_msg => 400, :message => "Parameters must include identifier and root url." }
    end

    def forbidden
      { :status_msg => 403, :message => "Client already exists" }
    end

    def params_valid?
      !params[:identifier].nil? && !params[:rootUrl].nil?
    end

    def client_exists?
      !(Client.find_by identifier: params[:identifier]).nil?
    end
  end
end
