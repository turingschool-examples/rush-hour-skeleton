# require 'byebug'

module TrafficSpy
  class Server < Sinatra::Base

    STATUS_CODES = { 200 => "200 OK",
                     400 => "400 Bad Request",
                     403 => "403 Forbidden" }

    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      source_data = { identifier: params["identifier"],
                        root_url: params["rootUrl"] }

      if Source.exists?(source_data)
        status 403
        body "Identifier already exists"
      else
        @source = Source.create(source_data)
        if @source.valid?
          hash = {identifier: @source.identifier}
          body hash.to_json
        else
          status 400
          body "Missing parameter, the required parameters are 'identifier' and 'rootUrl'"
        end
      end
    end

    post '/sources/:id/data' do |id|
      if Source.exists?(id)
        status 200
      end
    end
  end
end


# register Sinatra::Partial
#   set :partial_template_engine, :erb
