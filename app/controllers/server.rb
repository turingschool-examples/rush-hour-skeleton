module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    get '/' do

    end

    get '/sources' do
      @clients = Client.all

    end

    post '/sources' do
      client = Client.new("identifier" => params[:identifier], "root_url" => params[:rootUrl])
      if params[:identifier].nil? || params[:rootUrl].nil?
        status 400
        body "Bad Request: Please include both an identifer and root url."
      elsif Client.exists?(:identifier => params[:identifier])
        status 403
        body "Forbidden: That identifier is already in use. Please choose a new identifier."
      else
        client.save
        status 200
        body "Success: {'identifier':#{params[:identifier]}}"
      end
    end

    get '/sources/:identifier' do |identifier|
      @identifier = identifier
      client = Client.find_by(identifier: identifier)
      @payloads = Payload.where(client_id: client.id)
      @requests = client.requests
      @urls = client.urls
      @user_agent_stats = client.user_agent_stats
      @resolutions = client.resolutions
      erb :show_client
    end

    post '/sources/:identifier/data' do |identifier|

      if params[:payload].nil?
        status 400
        body "Missing Payload"
      elsif !Client.exists?(:identifier => identifier)
        status 403
        body "Application not registered"
      else
        parsed_data = PayloadParser.parser(params[:payload])
        payload = PayloadBuilder.build(parsed_data, identifier)
        if payload.new_record?
          payload.save
          status 200
          body "Yay"
        else
          status 403
          body "Already received request"
        end
      end
    end



  end

end
