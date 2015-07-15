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
      elsif site.errors.full_messages.join.include? ("blank")
        status 400
        body site.errors.full_messages.join(", ")
      else
        status 403
        body site.errors.full_messages.join(", ")
      end
    end

    not_found do
      erb :error
    end

    post "/sources/:identifier/data" do
      payload = JsonParser.parse(params[:payload])
      Payload.new(payload)
    end
  end
end
