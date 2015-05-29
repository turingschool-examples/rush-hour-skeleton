require 'digest'
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

    post '/sources/:identifier/data' do |identifier|
      
      if Source.exists?(identifier: identifier)

        sha = Payload.generate_sha(params.values.join)

        if Payload.exists?(sha: sha)
          status 403
          body "Duplicate payload detected!"
        else
          Payload.create({sha: sha})
          body "success"
        end
      else
        if params.keys.size == 3
          status 400
          body "Payload missing"
        else
          status 403 
          body "Application not registered"
        end
      end
    end
  end
end

