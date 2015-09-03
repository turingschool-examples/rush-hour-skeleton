module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      messenger = SourceMessenger.new(params)
      status messenger.status
      body messenger.message
    end

    post '/sources/:identifier/data' do
      if params[:payload].nil? || params[:payload].empty?
        status 400
        body "Missing Payload"
      else
        messenger = VisitMessenger.new(params)
        status messenger.status
        body messenger.message
      end
    end

    not_found do
      erb :error
    end
  end
end
