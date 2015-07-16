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
      if Site.exists?(:identifier => identifier)
        @identifier = identifier
        erb :dashboard
      else
        @message = "The identifier, #{identifier}, does not exist."
        erb :message
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
        #url_data = parsed_payload.select { |k, _| k == :path }
        url = Url.find_by(path: parsed_payload[:path])
        if url.blank?
          url = Url.create(path: parsed_payload[:path])
          event = Event.find_by(name: parsed_payload[:event_name])
          if event.blank?
            event = Event.create(name: parsed_payload[:event_name])
          end
          referrer = Referrer.find_by(path: parsed_payload[:referred_by])
          if referrer.blank?
            referrer = Referrer.create(path: parsed_payload[:referred_by])
          end
          browser = Browser.find_by(name: parsed_payload[:browser] )
          if browser.blank?
            browser = Browser.create(name: parsed_payload[:browser] )
          end
          platform = Platform.find_by(name: parsed_payload[:platform] )
          if platform.blank?
            platform = Platform.create(name: parsed_payload[:platform] )
          end
          request_type = RequestType.find_by(verb: parsed_payload[:request_type])
          if request_type.blank?
            request_type = RequestType.create(verb: parsed_payload[:request_type] )
          end
          payload = url.payloads.new(resolution_width: parsed_payload[:resolution_width], resolution_height: parsed_payload[:resolution_height],requested_at: parsed_payload[:requested_at], responded_in: parsed_payload[:responded_in], event_id: event.id, referrer_id: referrer.id, browser_id: browser.id,
          platform_id: platform.id, request_type_id: request_type.id, sha: sha)
        else
          event = Event.find_by(name: parsed_payload[:event_name])
          if event.blank?
            event = Event.create(name: parsed_payload[:event_name])
          end
          referrer = Referrer.find_by(path: parsed_payload[:referred_by])
          if referrer.blank?
            referrer = Referrer.create(path: parsed_payload[:referred_by])
          end
          browser = Browser.find_by(name: parsed_payload[:browser] )
          if browser.blank?
            browser = Browser.create(name: parsed_payload[:browser] )
          end
          platform = Platform.find_by(name: parsed_payload[:platform] )
          if platform.blank?
            platform = Platform.create(name: parsed_payload[:platform] )
          end
          request_type = RequestType.find_by(verb: parsed_payload[:request_type])
          if request_type.blank?
            request_type = RequestType.create(verb: parsed_payload[:request_type] )
          end
          payload = url.payloads.new(resolution_width: parsed_payload[:resolution_width], resolution_height: parsed_payload[:resolution_height],requested_at: parsed_payload[:requested_at], responded_in: parsed_payload[:responded_in], event_id: event.id, referrer_id: referrer.id, browser_id: browser.id,
          platform_id: platform.id, request_type_id: request_type.id, sha: sha)
          if payload.save
            status 200
        end
      end
    end
  end




        not_found do
      erb :error
    end

  end
end
