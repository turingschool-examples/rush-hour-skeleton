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
      site = Site.find_by(:identifier => identifier)
      @identifier = identifier

      if site.blank?
        @message = "The identifier, #{identifier}, does not exist."
        erb :message
      else
        @sorted_urls = site.payloads.group(:url).count.sort_by {  |_, v| v }.reverse
        @browsers = site.payloads.group(:browser).count.sort_by { |_, v| v }.reverse
        @platforms = site.payloads.group(:platform).count.sort_by { |_, v| v }.reverse
        @screens = site.payloads.group(:resolution_width, :resolution_height).count.sort_by { |_, v| v }.reverse
        @response_times = site.payloads.group(:url).average(:responded_in).sort_by {  |_, v| v }
        erb :dashboard
      end

    end

    post "/sources/:identifier/data" do |identifier|
      site = Site.find_by(:identifier => identifier)
      sha = Payload.create_sha(params[:payload])
      sha_exists = Payload.exists?(:sha => sha)
      if !params[:payload]
        status 400
        body "Payload is missing"
      elsif site.blank?
        status 403
        body "Application not registered"
      elsif sha_exists
        status 403
        body "Payload already received"
      else
        parsed_payload = JsonParser.parse(params[:payload])
        url = Url.find_or_create_by(path: parsed_payload[:path], site_id: site.id)
        event = Event.find_or_create_by(name: parsed_payload[:event_name])
        referrer = Referrer.find_or_create_by(path: parsed_payload[:referred_by])
        browser = Browser.find_or_create_by(name: parsed_payload[:browser] )
        platform = Platform.find_or_create_by(name: parsed_payload[:platform] )
        request_type = RequestType.find_or_create_by(verb: parsed_payload[:request_type])
        payload = url.payloads.new(resolution_width: parsed_payload[:resolution_width], resolution_height: parsed_payload[:resolution_height],requested_at: parsed_payload[:requested_at], responded_in: parsed_payload[:responded_in], event_id: event.id, referrer_id: referrer.id, browser_id: browser.id,
        platform_id: platform.id, request_type_id: request_type.id, sha: sha)

        if payload.save
          status 200
        end
      end
    end




        not_found do
      erb :error
    end

  end
end
