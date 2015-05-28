# require 'byebug'

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
          status 200
          hash = {identifier: @source.identifier}
          body hash.to_json
        else
          status 400
          body @source.errors.messages
        end
      end
    end
  end
end


# register Sinatra::Partial
#   set :partial_template_engine, :erb
