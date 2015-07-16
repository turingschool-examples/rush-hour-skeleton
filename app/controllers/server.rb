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
      # require 'pry'; binding.pry
      exist = Registration.exists?(identifier: identifier)

      if !exist
        status 403
        body "Application Not Registered - 403 Forbidden"
      elsif params[:payload] == nil
        status 400
        body "Missing Payload - 400 Bad Request"
      else
        current_sha = Digest::SHA1.hexdigest(Parser.parse(params[:payload].to_s).to_s)
        # current_sha = Digest::SHA1.hexdigest(params[:payload])

        if Payload.exists?(payload_sha: current_sha)
          status 403
          body "Already Received Request - 403 Forbidden"
        else
          registration = Registration.find_by(:identifier => identifier)
          registration.urls.create(Parser.parse(params[:payload].to_s, "url"))
          payload = registration.payloads.last
          payload.update(payload_sha: current_sha)
          status 200
          body "Success"
        end
      end
    end
  end
end
