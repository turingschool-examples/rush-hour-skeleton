module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      source = Source.create(:root_url => params[:rootUrl], :identifier => params[:identifier])
      {:identifier => source.identifier}.to_json
    end

    not_found do
      erb :error
    end
  end
end
