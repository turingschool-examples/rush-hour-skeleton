module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      source_attributes = {}
      source_attributes[:root_url] = params[:rootUrl]
      source_attributes[:identifier] = params[:identifier]

      source = Source.new(source_attributes)

      if source.save
        #return 200
        body "Successfully created"
      else
        {"identifier":"jumpstartlab"}
      end
    end

    not_found do
      erb :error
    end
  end
end
