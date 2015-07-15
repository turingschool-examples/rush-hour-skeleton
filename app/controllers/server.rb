module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      site = Site.new(params)

      if site.save
        status 200
        body "{'#{params.keys.first}':'#{site.identifier}'}"
      elsif site.errors.full_messages.join.include?("blank")
        status 400
        body site.errors.full_messages.join(", ")
      else
        status 403
        body site.errors.full_messages.join(", ")
      end
    end

    post "/sources/:identifier/data" do
      if !params[:payload]
        status 400
        body "Payload is missing"
      else
        parsed_payload = JsonParser.parse(params[:payload])
        # url = Url.new(parsed_payload.select { |k, _| k == :path })
        payload = Payload.new(parsed_payload.select { |k, _| k == :resolution_width || k == :resolution_height || k == :requested_at || k == :responded_in })
        # browser = Browser.new(parsed_payload.select { |k, _| k == :browser })
        # event = Event.new(parsed_payload.select { |k, _| k == :event })
        # platform = Platform.new(parsed_payload.select { |k, _| k == :platform })
        # referrer = Referrer.new(parsed_payload.select { |k, _| k == :referrer })
        # request_type = RequestType.new(parsed_payload.select { |k, _| k == :request_type })
        if payload.save
          status 200
        else
          status 403
        end
      end
    end

    not_found do
      erb :error
    end

  end
end
