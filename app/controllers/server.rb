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

    get '/sources/:id/urls/:extension' do | id, extension |
      application = Application.find_by(identifier: id)
      @url_ = application.urls.find_by(path: extension)
      erb :url
    end

    get '/sources/:id/events' do |id|
      @application = Application.find_by(identifier: id)
      # @events = application.received_events
      #
      # events.find_by(path: extension)
      erb :index

    end

    # get '/sources/:id/events/:event_name' do |id, event_name|
    #
    # end

    not_found do
      erb :error
    end
  end
end
