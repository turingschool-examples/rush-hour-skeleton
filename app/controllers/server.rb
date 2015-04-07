require 'json'
require 'byebug'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do 
      source = Source.new(root_url: params["rootUrl"], identifier: params["identifier"])
      if Source.find_by(identifier: source.identifier)
        status 403
        body "Identifier already exists"
      elsif source.save
        status 200
        body JSON.generate({ :identifier => source.identifier })
      else
        status 400
        body source.errors.full_messages
      end
    end

    post '/sources/:identifier/data' do |identifier|
      payload = Payload.create(
        url: params[:payload => "url"],
        requested_at: params[:payload => "requestedAt"],
        responded_in: params[:payload => "respondedIn"],
        referred_by: params[:payload => "referredBy"],
        request_type: params[:payload => "requestType"],
        parameters: params[:payload => "parameters"],
        event_name: params[:payload => "eventName"],
        user_agent: params[:payload => "userAgent"],
        resolution_width: params[:payload => "resolutionWidth"],
        resolution_height: params[:payload => "resolutionHeight"],
        ip: params[:payload => "ip"],
        source_id: params[:payload => Source.find_by(identifier: identifier).id]
        )
    end
  end
end
