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
      @application = Application.find_by(identifier: id)
      erb :index
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
      if @application.events.count == 0
        erb :no_events
      else
        erb :events
      end
    end

    # get '/sources/:id/events/:event_name' do |id, event_name|
    #
    # end

    not_found do
      erb :error
    end
  end
end
