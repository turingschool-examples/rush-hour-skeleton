module RushHour
  class Server < Sinatra::Base

    not_found do
      erb :error
    end

    post '/sources' do
      ClientHelper.parse_client_params(params)
    end

    get '/sources/:identifier' do |identifier|
      @client = ClientHelper.find_client(identifier)
       
      unless @client.nil?
        if @client.payload_requests.empty?
          erb :app_error, locals: { msg: "No payload data has been received for this source." }
        else
          erb :statistics
        end
      else
        erb :app_error, locals: { msg: "Identifier does not exist" }
      end
    end

    post '/sources/:identifier/data' do |identifier|
      client = ClientHelper.find_client(identifier)
      return ApplicationHelper.status_message(403, "403 Forbidden - Application not registered") unless client

      payload_request = PayloadRequestHelper.create_payload_request(client, params)
      PayloadRequestHelper.payload_status_message(params, payload_request)
    end
  end
end
