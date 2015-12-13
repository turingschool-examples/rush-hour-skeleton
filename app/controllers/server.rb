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
      erb :urls
    end

    get '/sources/:id/urls/*' do | id, splat |
      application = Application.find_by(identifier: id)
<<<<<<< HEAD
      @url = app.urls.find_by(path: extension)
      erb :url
=======
      if @url_ = application.urls.find_by(path: splat)
        erb :url
      else
        erb :url_not_requested
      end
>>>>>>> 21dfb0fb8c84dfb8177ff23adacb409aa9ce41bb
    end

    get '/sources/:id/events' do |id|
      @application = Application.find_by(identifier: id)
      # @events = application.received_events
      #
      # events.find_by(path: extension)
      erb :events

    end

    get '/sources/:id/events/:event_name' do |id, event_name|

      erb :event
    end

    not_found do
      erb :error
    end
  end
end
