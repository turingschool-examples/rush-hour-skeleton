module RushHour
  require_relative "../models/client_helper"
  class Server < Sinatra::Base
    include ClientHelper

    not_found do
      erb :error
    end

    post '/sources' do
      ca = ClientAnalyzer.new(params)
      new_param = ca.parse_client_params
      client = Client.new(new_param)
      if client.valid_params(new_param) == true
        status 403
        body "Client already exists."
      elsif client.save
        status 200
        body "Client creation successful!"
      else
        status 400
        body "Client identifier or root url not provided."
      end
    end

    post '/sources/:identifier/data' do |identifier|
      parser = Parser.new
      client = Client.find_by(identifier: identifier)
      if client.nil?
        status 403
        body "Url does not exist"
      elsif parser.parse_payload(params[:payload], identifier)
        @errors = parser.payload.errors.full_messages.join(", ")
        if @errors.include?("can't be blank")
          status 400
          body "Payload is missing"
        elsif @errors.include?("already been taken")
          status 403
          body "Payload already received"
        else
          status 200
          body "OK"
        end
      end
    end

    get '/sources/:IDENTIFIER' do |identifier|
      if client = Client.find_by(identifier: identifier)
        @requests = client.payload_requests
        @user_agents = client.user_agent_bs
        @resolutions = client.resolutions
        @events = client.events
        if @requests.count > 0
          erb :index
        else
          body "Hmm.. it seems as if no payload data has been recieved for this source."
        end
      else
        body "Hmm.. it seems as if the identifier does not exist."
      end
    end

    get '/sources/:IDENTIFIER/urls/:RELATIVEPATH' do |identifier, relativepath|
      find_urls_from_a_payload_requests(identifier, realtivepath)
      @single_url.count > 0 ?  (erb :show) : (erb :not_requested)
    end
    
  end
end
