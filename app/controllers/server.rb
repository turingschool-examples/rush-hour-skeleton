module TrafficSpy
  class Server < Sinatra::Base

    helpers do
      def payload_routing(user, id)
        if user.payloads.count == 0
          erb :no_payload_data, locals: {id: id}
        else
          erb :application_statistics
        end
      end
    end

    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    get '/sources/:id' do |id|
      if @user = TrafficSpy::User.find_by(identifier: id)
        payload_routing(@user, id)
      else
        erb :identifier_does_not_exist, locals: {id: id}
      end
    end

    get '/sources/:id/urls/:relative_path' do |id, relative_path|
      @user = TrafficSpy::User.find_by(identifier: id)
      full_path = @user.root_url + '/' + relative_path
      unless @user.payloads.known_url?(full_path)
        erb :unknown_url
      else
        @url_payloads = @user.payloads.where(url: full_path)
        erb :url_data, locals: { relative_path: relative_path }
      end
    end

    get '/sources/:id/events' do |id|
      @user = TrafficSpy::User.find_by(identifier: id)
      if @user.payloads.event_frequency.count == 0
        erb :no_events, locals: { id: id }
      else
        erb :events_index
      end
    end

    get '/sources/:id/events/:event_name' do |id, event_name|
      @user = TrafficSpy::User.find_by(identifier: id)
      erb :error
    end

    post '/sources' do
      TrafficSpy::RegistrationParser.new(params).parsing_validating
    end

    post '/sources/:id/data'  do |id|
      TrafficSpy::PayloadParser.new(params).payload_response
    end

    post '/enter_id' do
      @current_user = params[:name]
      redirect "/sources/#{@current_user}"
    end

  end
end
