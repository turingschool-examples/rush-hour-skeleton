module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post "/sources" do
      user_params = {}
      user_params[:root_url]    = params[:rootUrl]
      user_params[:identifier]  = params[:identifier]

      user = User.new(user_params)

      if user.save
        body "{identifier: #{params[:identifier]}}"
      else
        message = user.errors.messages.to_a.flatten
        registrator = UserRegistrator.new(message)
        status registrator.error_status
        body registrator.error_message
      end
    end

    post "/sources/:identifier/data" do |identifier|
      payload_params = params.to_json
      payload_params = JSON.parse(payload_params)

      user = User.find_by_identifier(identifier)
      sub_url = user.sub_urls.new(:sub_url => payload_params["url"])

      if sub_url.save
        "cake"
      end
    end

    not_found do
      erb :error
    end
  end
end
