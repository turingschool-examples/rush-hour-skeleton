require 'json'
module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      # registration_hander = RegistrationHander.new(params)
      # status registration_hander.status
      # body registration_hander.body
      reg = Registration.new({ identifier: params["identifier"], url: params["rootUrl"] })

      if params['identifier'] == nil || params['rootUrl'] == nil
        status 400
        body "Missing Parameters - 400 Bad Request"
      else
        if reg.save
          status 200
          body "{'identifier' : '#{params['identifier']}'}"
        else
          status 403
          body "Identifier Already Exists - 403 Forbidden"
        end

      end
    end

    post "/sources/:identifier/data" do |identifier|
      data_handler = DataProcessingHandler.new(params[:payload], identifier)
      status data_handler.status
      body data_handler.body
  end
end
end
