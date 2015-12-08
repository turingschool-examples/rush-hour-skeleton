module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      if AppRegistrar.all.any? {|app| app.identifier == params[:identifier]}

        status 403
        body "Identifier Already Exists"

      else
        app_reg  = AppRegistrar.create(identifier: params[:identifier],
                                       root_url: params[:rootUrl])

        if app_reg.save
          "{identifier: #{params[:identifier]}}"

        else
          status 400

            if params.has_key?('identifier')
              body "Missing root URL"
            else
              body "Missing Identifier"
            end
        end
      end
    end

    not_found do
      erb :error
    end
  end
end
