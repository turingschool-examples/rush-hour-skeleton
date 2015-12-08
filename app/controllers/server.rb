module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      user = User.create(identifier: params[:identifier], root_url: params[:rootUrl])
      id = params[:identifier]
      hash =   {'identifier': id}
      JSON.generate(hash)
    end
  end
end
