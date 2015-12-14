module TrafficSpy
  class Server < Sinatra::Base

    helpers do
      include Helpers
    end

    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    get '/sources/:id' do |id|
      if user(id)
        stats_viewing(id)
      else
        erb :identifier_does_not_exist, locals: {id: id}
      end
    end

    get '/sources/:id/urls/:relative_path' do |id, relative_path|
      user(id)
      if @user.payloads.known_url?(full_path(relative_path))
        @url_payloads = @user.payloads.where(url: full_path(relative_path))
        erb :'url_data/url_data', locals: { relative_path: relative_path }
      else
        erb :unknown_url
      end
    end

    get '/sources/:id/events' do |id|
      user(id)
      if @user.payloads.event_frequency.count == 0
        erb :no_events, locals: { id: id }
      else
        erb :'event_stats/events_index'
      end
    end

    get '/sources/:id/events/:event_name' do |id, event_name|
      user(id)
      if @user.payloads.exists?(event_name: event_name)
        erb :'event_stats/event_data', locals: { event_name: event_name}
      else
        erb :no_event, locals: { event_name: event_name }
      end
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
