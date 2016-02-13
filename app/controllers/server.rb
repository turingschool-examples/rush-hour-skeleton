module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    def parse_client_params(params)
      client = Client.new(identifier: params[:identifier],
                          root_url:   params[:rootUrl])

      if client.save
        [200, { identifier: client.identifier }.to_json]
      elsif client.errors.full_messages.first == "Identifier has already been taken"
        [403, "403 Forbidden - Identifier already exists"]
      else
        [400, "400 Bad Request - #{client.errors.full_messages.join(", ")}"]
      end
    end

    post '/sources' do
      parse_client_params(params)
    end
  end
end
