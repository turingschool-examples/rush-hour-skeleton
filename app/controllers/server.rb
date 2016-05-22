module RushHour
  class Server < Sinatra::Base
    not_found do
      haml :error
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

    get '/sources/:identifier' do |identifier|
      if Client.find_by(identifier: identifier)
        @client = Client.find_by(identifier: identifier)
        if @client.check_for_payloads
          haml :show
        else
          @display_error = "There is currently no payload data for this client."
          haml :error
        end
      else
        @display_error = "This Client Does Not Exist"
        haml :error
      end
    end

    get '/sources/:identifier/urls/:relativepath' do |identifier, path|
      @client = Client.find_by(identifier: identifier)
      name = Url.get_name_by_relative_path(path)
      if @client.urls.find_by(name: name)
        @url = @client.urls.find_by(name: name)
        haml :url
      else
        @display_error = "Url not found for given client"
        haml :error
      end
    end


    get '/sources/:identifier/events/:event_name' do |identifier, event_name|
      @client = Client.find_by(identifier: identifier)
      if EventName.find_by(name: event_name)
        @event_name = event_name
        @hour_breakdown = @client.breakdown_by_hour(event_name)
        haml :event_name
      else
        @display_error = "Event has not been defined."
        haml :error
      end
    end


  end
end
