module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      if params[:identifier] && params[:rootUrl]

        user = User.new(identifier: params[:identifier], root_url: params[:rootUrl])
        if user.save
          id = params[:identifier]
          hash =   {'identifier': id}
          JSON.generate(hash)
        else
          status(403)
          "Identifier already exists."
        end
      else
        status(400)
        "Missing all required details."
      end
    end
  end
end
