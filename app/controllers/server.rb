module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.create({identifier: params["identifier"],root_url: params["rootUrl"]})
      if client.errors.full_messages.join(",").include?("can't be blank")
        status 400
        body client.errors.full_messages.join(", ")
      elsif client.errors.full_messages.join(",").include?("has already been taken")
        status 403
        body client.errors.full_messages.join(", ")
      else
        status 200
      end
    end

    post '/sources/:identifier/data' do
      parsed_payload = Parser.parse_payload(params["payload"])
      result = DataLoader.load(parsed_payload, params["identifier"])
      status result[:status]
      body result[:body]
    end

    get '/sources/:identifier/urls/:relativepath' do |identifier, path|
      @client = Client.find_by(identifier: identifier)
      name = Url.get_name_by_relative_path(path)
      if @client.urls.find_by(name: name)
        @url = @client.urls.find_by(name: name)
        haml :url
      else
        redirect not_found
      end
    end

  end
end
