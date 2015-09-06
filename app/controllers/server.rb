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
      browser_payload = validator.browser_parser(payload_params['userAgent'])


      if Payload.new(digest: digest).valid?
        url = Url.find_or_create_by(url: payload_params['url'])

        browser = Browser.find_or_create_by(browser: browser_payload)









        # binding.pry
# user_agent.browser
# # => 'Chrome'
# user_agent.version
# # => '19.0.1084.56'
# user_agent.platform
# # => 'Macintosh'



          unless source.nil?
            payload = Payload.new(digest: digest, source_id: source.id, url_id: url.id, browser_id: browser.id)
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
      @source = Source.find_by_identifier(identifier)
      @slugs = @source.urls.group(:url).count
      @slugs = @slugs.map do |slug|
        slug[0]
      end

      @browser_counts = @source.browsers.group(:browser).count
      @browsers = @browser_counts

      erb :show
    end

    not_found do
      erb :error
    end
  end
end
