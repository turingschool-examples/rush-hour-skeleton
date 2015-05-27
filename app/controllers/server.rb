require 'pry'
module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      # binding.prly
      @source = Source.create(params[:source])
      @source.to_json
      status 200
      # body "created!"
    end
  end
end


# register Sinatra::Partial
#   set :partial_template_engine, :erb
