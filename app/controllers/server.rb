module RushHour
  class Server < Sinatra::Base

    not_found do
      erb :error
    end

    post '/sources' do
      ClientHelper.parse_client_params(params)
    end

    post '/sources/:identifier/data' do |identifier|
      client = ClientHelper.find_client(identifier)
      return ApplicationHelper.status_message(403, "403 Forbidden - Application not registered") unless client

      payload_request = PayloadRequestHelper.create_payload_request(client, params)

      PayloadRequestHelper.payload_status_message(params, payload_request)
    end
  end
end
