module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      messenger = Messenger.new(params, "Source")
      status messenger.status
      body messenger.message
    end

    post '/sources/:identifier/data' do
      if !Source.find_by(identifier: params[:identifier])
        status 403
        body "Application Not Registered"
      elsif params[:payload].nil? || params[:payload].empty?
        status 400
        body "Missing Payload"
      else
        attributes = JSON.parse(params[:payload])
        sha_identifier = Digest::SHA1.hexdigest(params[:payload])
        attributes[:sha_identifier] = sha_identifier
        messenger = Messenger.new(attributes, "Visit")
        status messenger.status
        body messenger.message
      end
    end

    not_found do
      erb :error
    end
  end
end
