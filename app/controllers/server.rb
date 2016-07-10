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
    parsed_payload = Parser.parse_payload(params["payload"])
    result = DataLoader.load(parsed_payload, params["identifier"])

    status result[:body]
    status result[:status]
  end


  get '/sources/:identifier' do |identifier|

    @client = Client.find_by(identifier: identifier)
    pass unless @client
    payload_requests = @client.payload_requests
    pass if payload_requests.empty?
    erb :dashboard
  end

  not_found do
      erb :error
    end
  end
end
