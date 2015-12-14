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
        erb :error, locals: {message: "Application not registered"}
      elsif @app.requests.empty?
        erb :error, locals: {message: "No documented requests"}
      else
        erb :urls
      end
    end

    get '/sources/:id/urls/*' do | id, splat |
      application = Application.find_by(identifier: id)
      if @url_ = application.urls.find_by(path: splat)
        erb :url
      else
        erb :error, locals: {message: "No documented requests"}
      end
    end

    get '/sources/:id/events' do |id|
      @application = Application.find_by(identifier: id)

      if @application.events.count == 0
        erb :error, locals: {message: "No events have been defined"}
      else
        erb :events
      end
    end

    get '/sources/:id/events/:event_name' do |id, event_name|
      @app = Application.find_by(identifier: id)
      @event = Event.find_by(name: event_name)
      @hour_breakdown = @event.sorted_list_by_hour(@app.id)

      erb :event
    end

    not_found do
      erb :error, locals: {message: "Oops! We don't know what you mean"}
    end
  end
end
