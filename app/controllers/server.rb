module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      haml :index
    end

    post '/sources' do
      response_status, response_body =  TrafficSpy::RegisterApplication.new(params).save

      status response_status
      body response_body
    end

    post '/sources/:id/data' do |id|
      response_status, response_body = TrafficSpy::ProcessPayload.new(params[:payload], id).process

      status response_status
      body response_body
    end

    get '/sources/:id/urls/:path' do |id, path|
      @url = "/" + path
      @id = id
      @app = TrafficSpy::Application.find_by(identifier: id)
      @urls = @app.payloads.where(relative_path: @url)

      if @urls.empty?
        haml :application_url_statistics_error
      else
        haml :application_url_statistics
      end
    end

    get '/sources/:id' do |id|
      @app = TrafficSpy::Application.find_by(identifier: id)
      haml :application_details
    end

    get '/sources/:id/events' do |id|
      @app = TrafficSpy::Application.find_by(identifier: id)
      haml :events_index
    end

    get '/sources/:id/events/:event' do |id, event|
      @app = TrafficSpy::Application.find_by(identifier: id)
      @event_payloads = app.payloads.where(event: event)
      @event = event
      haml :event_details
    end

    not_found do
      haml :error
    end
  end
end
