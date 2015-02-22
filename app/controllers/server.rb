module TrafficSpy
  class Server < Sinatra::Base

    def link_user_to_identifier(identifier)
      User.find_by_identifier(identifier)
    end

    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      user = User.new(params[:sources])
    	case
    	when user.save
    		status 200
    		body 'success'
    	else
    		status 400
    		body "#{user.errors.full_messages.join(', ')}"
    	end
    end

    get '/sources/:identifier' do |identifier|
      if @user = link_user_to_identifier(identifier)
        erb :dashboard
      else
        erb :error
      end
    end

    post '/sources/:identifier/data' do |identifier|
      @user = link_user_to_identifier(identifier)
    	@user.payloads.create(params["payload"])
    end

    get '/sources/:identifier/events' do |identifier|
      @user = link_user_to_identifier(identifier)
      @events = @user.payloads.events.all
      @identifier = identifier
      erb :events
    end
  end
end
