module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      data = JSON.parse(params[:client])
      client = Client.new(data)
      if client.save

      else
        status 400
        "400 Bad Request - #{client.errors.full_messages.join(", ")}"
      end
    end
  end
end
