module TrafficSpy
  class Server < Sinatra::Base
    set :show_exceptions, false

    get '/' do
      erb :index
    end

    post '/sources' do
      source = Source.new(:root_url => params[:rootUrl], :identifier => params[:identifier])
      if source.save
        {:identifier => source.identifier}.to_json
      else
        status_message(source)
        body source.errors.full_messages.join(", ")
      end
    end

    not_found do
      erb :error
    end

    def status_message(source)
      if source.errors.full_messages.join(", ") == "Identifier has already been taken"
        status 403
      elsif source.errors.full_messages.join(", ") == "Root url can't be blank"
        status 400
      elsif source.errors.full_messages.join(", ") == "Identifier can't be blank"
        status 400
      end
    end

  end
end
