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
        messenger = Messenger.new(build_attributes(params), "Visit")
        status messenger.status
        body messenger.message
      end
    end

    get '/sources/:identifier' do
      if source = Source.find_by(identifier: params[:identifier])
        builder = VariableBuilder.new(params, source)
        erb :show, locals: builder.variables
      else
        erb :error
      end
    end

    not_found do
      erb :error
    end

    private

    def build_attributes(params)
      attributes = JSON.parse(params[:payload])
      sha_identifier = Digest::SHA1.hexdigest(params[:payload])
      attributes[:sha_identifier] = sha_identifier
      attributes[:source_id] = Source.find_by(identifier: params[:identifier]).id
      attributes
    end
  end
end
