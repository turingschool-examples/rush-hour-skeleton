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

      if site.blank?
        @message = "The identifier, #{identifier}, does not exist."

        erb :message
      else
        @dashboard_renderer = DashboardRenderer.new(identifier, site)

        erb :dashboard
      end
    end

    get '/sources/:identifier/urls/:relative_path' do |identifier, relative_path|
      site = Site.find_by(:identifier => identifier)
      url = site.urls.find_by(:path => "#{site.root_url}/#{relative_path}")

      if url.blank?
        @message = "The URL path, /#{relative_path}, has not been requested."

        erb :message
      else
        @url_data_renderer = UrlDataRenderer.new(relative_path, url)

        erb :url_data
      end
    end

    get '/sources/:indentifier/events' do |identifier|
      @identifier = identifier
      site = Site.find_by(:identifier => @identifier)
      @events = site.payloads.group(:event).count.sort_by { |_, v| v }.reverse

      erb :event_index
    end

    get '/sources/:indentifier/events/:event_name' do |identifier, event_name|
      site = Site.find_by(:identifier => identifier)
      event = site.events.find_by(:name => event_name)

      if event.blank?
        @message = "The event, '#{event_name}', has not been requested."

        erb :message
      else
        @event_data_renderer = EventDataRenderer.new(identifier, event_name, site, event)

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
        if Payload.process(site, sha, params[:payload]).save
          status 200
        end
      end
    end

    not_found do
      erb :error
    end
  end
end
