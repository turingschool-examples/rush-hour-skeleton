module RushHour
  class Server < Sinatra::Base

    post '/sources' do
    client = Client.create({identifier: params["identifier"],root_url: params["rootUrl"]})
    if client.error_message.include?("You need to give me my shit")
      status 400
      body client.error_message
    elsif client.error_message.include?("has already been taken")
      status 403
      body client.error_message
    else
      status 200
    end
  end

    not_found do
      erb :error
    end
  end
end
