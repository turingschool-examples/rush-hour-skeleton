module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      app_reg  = AppRegistrar.create(identifier: params[:identifier],
                                     root_url: params[:rootUrl])
      if app_reg.save
        "{identifier: #{params[:identifier]}}"
      else
        status 400
        if params.has_key?(:identifier)
            body "Missing root URL"
        else
          body "Missing Identifier"
        end
      end
    end

    not_found do
      erb :error
    end
  end
end
