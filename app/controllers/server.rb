module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.new(params["identifier"], params["rootUrl"])
      if client.errors.full_messages.include?("Can't be blank")
        status 400
      elsif client.errors.full_messages.include?("Identifier: Already Exists")
        status 403
      else
        status 200
      end
    end


  end
end
