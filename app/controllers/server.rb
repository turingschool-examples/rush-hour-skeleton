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
      else
        status 400
        "400 Bad Request - #{client.errors.full_messages.join(", ")}"
      end
    end
  end
end
