module TrafficSpy


  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      client = Client.new(name: params["identifier"], root_url: params["rootUrl"])
        #save here
      #pass params to Validator

      if Client.find_by(name: params["identifier"])
        status 403
        body "Name already taken."
      elsif client.save
        body "Client created."
      else
        status 400
        body "Missing parameters."
        # client.errors.full_messages
      end
    end

    post '/sources/:identifier/data' do |identifier|
      ph = PayloadHandler.new(params)
      status ph.status
      body ph.body
    end

    get '/sources/:identifier' do |identifier|
      @client = Client.find_by(name: identifier)
      erb :application_details
    end

    not_found do
      erb :error
    end
  end
end
