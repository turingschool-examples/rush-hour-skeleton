require 'json'
require 'digest'

module TrafficSpy
  class Server < Sinatra::Base
    set :show_exceptions, false

    get '/' do
      erb :index
    end

    post '/sources' do
      source = Source.new(:root_url => params[:rootUrl], :identifier => params[:identifier])
      if source.save
        {:identifier => source.identifier}.to_json
      else
        status_message(source)
        body source.errors.full_messages.join(", ")
      end
    end

    post '/sources/:identifier/data' do |identifier|
      if params["payload"].nil?
        status 400
        body "payload can't be blank"
      elsif Source.where(:identifier => params["identifier"]).exists?
        json_payload = JSON.parse(params["payload"])
        data = Payload.new(:url => json_payload["url"],
                           :requested_at => json_payload["requestedAt"],
                           :responded_in => json_payload["respondedIn"],
                           :event_name => json_payload["eventName"],
                           :user_agent => json_payload["userAgent"],
                           :resolution_width => json_payload["resolutionWidth"],
                           :resolution_height => json_payload["resolutionHeight"],
                           :ip => json_payload["ip"],
                           :hex_digest => Digest::SHA2.hexdigest(params.to_s))

        if data.save
          body "Created Successfully"
        else
          status_message(data)
          body data.errors.full_messages.join(", ")
        end
      else
        status 403
        body "Identifier does not exist"
      end
    end

    get '/sources/jumpstartlab' do
      erb :source_page
    end

    not_found do
      erb :error
    end

    def status_message(source)
      if source.errors.full_messages.join(", ") == "Identifier has already been taken"
        status 403
      elsif source.errors.full_messages.join(", ") == "Root url can't be blank"
        status 400
      elsif source.errors.full_messages.join(", ") == "Identifier can't be blank"
        status 400
      elsif source.errors.full_messages.join(", ") == "Hex digest has already been taken"
        status 403
      end
    end
  end
end
