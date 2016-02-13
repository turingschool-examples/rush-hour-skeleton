module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.new(identifier: params[:identifier],
                          root_url:   params[:rootUrl])
      if client.save
        "It WORKS!!!"
      elsif client.errors.full_messages.first == "Identifier has already been taken"
        status 403
        "403 Forbidden - Identifier already exists"
      else
        status 400
        "400 Bad Request - #{client.errors.full_messages.join(", ")}"
      end
    end
  end
end
