module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      registrator = Registrator.new(params)
      status registrator.status
      body   registrator.response
    end

    post '/sources/:id/data' do |id|
      registrator = RequestManager.new(params)
      status registrator.status
      body   registrator.response
    end

    get '/sources/:id' do |id|
      @app = Application.find_by(identifier: id)

      if @app.nil?
        @message = "This application has not been registered"
        erb :application_error
      elsif @app.requests.empty?
        @message = "This application has no documented requests"
        erb :application_error
      else
        erb :urls
      end
    end

    get '/sources/:id/urls/*' do | id, splat |
      application = Application.find_by(identifier: id)
      if @url_ = application.urls.find_by(path: splat)
        erb :url
      else
        erb :url_not_requested
      end
    end

    get '/sources/:id/events' do |id|
      @application = Application.find_by(identifier: id)

      erb :events
    end

    get '/sources/:id/events/:event_name' do |id, event_name|
      @app = Application.find_by(identifier: id)
      @event = Event.find_by(name: event_name)

      # binding.pry
      @hour_breakdown = @event.sorted_list_by_hour(@app.id)

      erb :event
    end

    not_found do
      erb :error
    end
  end
end
