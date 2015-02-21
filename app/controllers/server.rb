module TrafficSpy
  class Server < Sinatra::Base

    get "/" do
      erb :index
    end

    post "/sources" do
      # pull this out into its own model
      source = Source.new(params)
      if source.save
        status 200
        body source.simplified_json
      else
        status_helper = StatusHelper.new(source.error_response)
        status status_helper.status
        body source.error_response
      end
    end

    post "/sources/:identifier/data" do |identifier|
      payload_generator = PayloadGenerator.call(params[:payload], identifier)
      status payload_generator.status
      body   payload_generator.message
    end

    get "/sources/:identifier/urls/*" do
      root_url = Source.find_by(identifier: params[:identifier]).root_url
      @created_url = UrlHelper.create_url(root_url, params[:splat].join("/"))

      if !Url.exists?(address: @created_url)
        erb :url_error
        status 404
      else
        
        erb :url_statistics
      end

    end

    not_found do
      erb :error
    end
  end
end
