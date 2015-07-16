module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      parsed_params = HashParser.parse(params)
      site = Site.new(parsed_params)

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

    get '/sources/:identifier' do |identifier|

      "Hello #{identifier}"

    end

    post "/sources/:identifier/data" do |identifier|
      site_exists = Site.exists?(:identifier => identifier)
      sha = Payload.create_sha(params[:payload])
      sha_exists = Payload.exists?(:sha => sha)

      if !params[:payload]
        status 400
        body "Payload is missing"
      elsif !site_exists
        status 403
        body "Application not registered"
      elsif sha_exists
        status 403
        body "Payload already received"
      else
        parsed_payload = JsonParser.parse(params[:payload])
        url_data = parsed_payload.select { |k, _| k == :path }
        url = Url.new(url_data)
        payload_data = (parsed_payload.select { |k, _| k == :resolution_width || k == :resolution_height || k == :requested_at || k == :responded_in })
        payload_data[:sha] = sha
        payload_data[:url_id] = url.id
        payload = Payload.new(payload_data)
        if payload.save && url.save
          status 200
        end
      end
    end



        not_found do
      erb :error
    end

  end
end
