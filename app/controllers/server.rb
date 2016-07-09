module RushHour
  class Server < Sinatra::Base

  post '/sources' do
    client = Client.create({identifier: params["identifier"],root_url: params["rootUrl"]})
    if client.error_message.include?("can't be blank")
      status 400
      body client.error_message
    elsif client.error_message.include?("has already been taken")
      status 403
      body client.error_message
    else
      status 200
    end
  end

  post '/sources/:identifier/data' do
    binding.pry
    parsed_payload = Parser.parse_payload(params["payload"])
    result = DataLoader.load(parsed_payload, params["identifier"])
    # status result[:status]
    # body result[:body]
  end

  not_found do
      erb :error
    end
  end
end
