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
      @site = Site.find_by(:identifier => identifier)
      @identifier = identifier

      if @site.blank?
        @message = "The identifier, #{identifier}, does not exist."
        erb :message
      else
        @sorted_urls = @site.payloads.group(:url).count.sort_by {  |_, v| v }.reverse
        @browsers = @site.payloads.group(:browser).count.sort_by { |_, v| v }.reverse
        @platforms = @site.payloads.group(:platform).count.sort_by { |_, v| v }.reverse
        @screens = @site.payloads.group(:resolution_width, :resolution_height).count.sort_by { |_, v| v }.reverse
        @response_times = @site.payloads.group(:url).average(:responded_in).sort_by {  |_, v| v }
        @paths = @site.urls.map do |url|
          path = url.path
          path.slice!(@site.root_url)
          path
        end
        erb :dashboard
      end

    end

    get '/sources/:identifier/urls/:relative_path' do |identifier, relative_path|
      @identifier = identifier
      @relative_path = relative_path
      site = Site.find_by(:identifier => identifier)
      @url = site.urls.find_by(:path => "#{site.root_url}/#{@relative_path}")

      if @url.blank?
        @message = "The URL path, /#{@relative_path}, has not been requested."

        erb :message
      else
        @fastest_response_time = @url.payloads.minimum(:responded_in)
        @slowest_response_time = @url.payloads.maximum(:responded_in)
        @average_response_time = @url.payloads.average(:responded_in).round(2)
        @http_verbs = @url.payloads.group(:request_type).count.sort_by { |_, v| v }.reverse
        @top_referrers = @url.payloads.group(:referrer).count.sort_by { |_, v| v }.reverse
        @top_browsers = @url.payloads.group(:browser).count.sort_by { |_, v| v }.reverse
        @top_platforms = @url.payloads.group(:platform).count.sort_by { |_, v| v }.reverse

        erb :url_data
      end
    end

    get '/sources/:indentifier/events' do |identifier|
      @identifier = identifier
      site = Site.find_by(:identifier => identifier)
      @events = site.payloads.group(:event).count.sort_by { |_, v| v }.reverse

      erb :event_index
    end

    get '/sources/:indentifier/events/:event_name' do |identifier, event_name|
      @identifier = identifier
      @event_name = event_name
      site = Site.find_by(:identifier => identifier)
      @event = site.events.find_by(:name => @event_name)

      if @event.blank?
        @message = "The event, '#{@event_name}', has not been requested."

        erb :message
      else
      events = site.payloads.where(:event_id => @event.id)
      hours = events.map { |event| Time.parse(event[:requested_at]).hour }
      @hour_count = hours.group_by{ |h| h }
      @day = {
        0 => 0,
        1 => 0,
        2 => 0,
        3 => 0,
        4 => 0,
        5 => 0,
        6 => 0,
        7 => 0,
        8 => 0,
        9 => 0,
        10 => 0,
        11 => 0,
        12 => 0,
        13 => 0,
        14 => 0,
        15 => 0,
        16 => 0,
        17 => 0,
        18 => 0,
        19 => 0,
        20 => 0,
        21 => 0,
        22 => 0,
        23 => 0,
      }
      @day.map do |k, v|
        if @hour_count[k] != nil
          @day[k] = @hour_count[k].size
        end
      end

      erb :event_data
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
