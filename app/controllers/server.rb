require 'byebug'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      identifier = Identifier.new(params[:identifier])
        # if identifier.title =
        #   status 403
        #   body "Duplicate Dummy!"
        if identifier.save
          status 200
          body "success"
        elsif identifier.title.nil?
          status 400
          body identifier.errors.full_messages
        elsif identifier.root_url.nil?
          status 400
          body identifier.errors.full_messages
        else
          status 403
          body identifier.errors.full_messages
        end
    end

    post '/sources/:title/data' do
      payload_data = parse(params[:payload])
        if payload_data.nil? || payload_data.empty?
          status 400
          body identifier.errors.full_messages
        elsif
          payload = Payload.new(payload_data)
          status 200
          body "success"
        #elsif identifier.title.nil?
          #status 400
          #body identifier.errors.full_messages
        else
          status 403
          body payload.errors.full_messages
        end
    end
  end
end
