# require 'byebug'
require 'digest'

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
        #  Source.duplicate_identifier  
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
      unless Source.exists?(identifier: identifier)
        body "Application not registered"
        status 403 
      else
        sha = Payload.generate_sha(params.values.join)
        if Payload.exists?(sha: sha)
          status 403
          body "Duplicate payload detected!"
        else
         Payload.create({sha: sha})
         body "success"
        end
      end
    end


    #given a registered user  we need to
    #convert the payload string into a SHA1 and check to make sure
    #it's not in the payload table.
    #
    #  Digest::SHA1.hexdigest(payload)
    #  
    #require 'digest'
  end
end


# register Sinatra::Partial
#   set :partial_template_engine, :erb
