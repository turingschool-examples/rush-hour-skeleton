module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.new(identifier: params[:identifier],
                          rootUrl: params[:rootUrl])

      if Client.exists?(identifier: client.identifier)
        status 403
        body "Client with identifier: \"#{client.identifier}\" already exists!\n"
      elsif client.save
        status 200
        body "{\"identifier\":\"#{client.identifier}\"}\n"
      else
        status 400
        body "#{client.errors.full_messages.join(", ")}\n"
      end
    end

  end
end
