module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      # pull this out into its own model
      source = Source.new(params)
      if source.save
        status 200
        body source.simplified_json
      else
        status_helper = StatusHelper.new(source.error_response)
        status status_helper.status
        body source.error_response
      end
    end

    get '/sources/:identifier/events' do
      @source = Source.find_by!(identifier: params[:identifier])
      events_by_source = @source.payloads.map {|payload| payload.event }
      @events = events_by_source.inject(Hash.new(0)) {|sum,event| sum[event]+=1; sum }.sort_by {|k,v| -v}
      erb :event_index
    end

    get '/sources/:indentifier/events/:EVENTNAME' do    
      #add sad path page if event is not defined
      #link back to events index page
      erb :event_details
    end

    post '/sources/:identifier/data' do |identifier|
      payload_generator = PayloadGenerator.call(params[:payload], identifier)
      status payload_generator.status
      body   payload_generator.message
    end

    not_found do
      erb :error
    end
  end
end
