module TrafficSpy

  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post "/sources" do
     source_params = {}
     source_params[:root_url]    = params[:rootUrl]
     source_params[:identifier]  = params[:identifier]

     source = Source.new(source_params)

      if source.save
        body "{identifier: #{params[:identifier]}}"
      else
        message = source.errors.messages.to_a.flatten
        registrator = SourceRegistrator.new(message)
        status registrator.error_status
        body registrator.error_message
      end
    end

    post "/sources/:identifier/data" do |identifier|

      if params['payload'] == nil
        status 400
        body 'Bad Request - Needs a payload'
        break
      end

      source = Source.find_by_identifier(identifier)
      validator = PayloadValidator.new(params['payload'], source)
      digest = validator.create_digest
      payload_params = validator.json_parser
      browser = validator.browser_parser(payload_params['userAgent'])
      operating_system = validator.os_parser(payload_params['userAgent'])


      if Payload.new(digest: digest).valid?
        url = Url.find_or_create_by(url: payload_params['url'])
        response = Response.find_or_create_by(
                     requested_at: payload_params['requestedAt'],
                     responded_in: payload_params['respondedIn'],
                     ip: payload_params['ip'])
        browser = Browser.find_or_create_by(browser: browser, operating_system:
        operating_system)
        resolution = Resolution.find_or_create_by(
                        resolution_width: payload_params['resolutionWidth'],
                        resolution_height: payload_params['resolutionHeight'])
         #this is where we add everything else

        unless source.nil?
            payload = Payload.new(digest: digest,
                                  source_id: source.id,
                                  url_id: url.id,
                                  resolution_id: resolution.id,
                                  browser_id: browser.id,
                                  response_id: response.id)

            if payload.save
              status 200
              body "OK"
            end
        else
          status 403
          body 'Forbidden - Must have registered identifier'
        end
      else
        status 403
        body 'Forbidden - Must be unique payload'
      end
    end

    get '/sources/:identifier' do |identifier|
      @source             = Source.find_by_identifier(identifier)
      @slugs              = Url.new.most_requested(@source)
      @average_responses  = Response.new.average_response_time(@source)
      @browser_counts     = Browser.new.list_browsers(@source)
      @os_counts          = Browser.new.list_operating_systems(@source)
      @resolutions        = Resolution.new.resolution_size(@source)
      @paths              = Url.new.path_parser(@source)

      erb :show
    end

    get '/sources/:identifier/events' do |identifier|
      @source = Source.find_by_identifier(identifier)
      @events = @source.events

      erb :event_index
    end

    get '/sources/:identifier/urls/:path' do |identifier, path|
      @source = Source.find_by_identifier(identifier)
      @paths = Url.new.path_parser(@source)

      if @paths.include?(path)
        status 200
        body 'OK'
        erb :"urls/show"
      else
        status 404
        body 'URL not found'
        not_found
      end
    end

    not_found do
      erb :error
    end
  end
end
