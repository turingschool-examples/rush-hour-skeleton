require 'json'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do
      erb :sources
    end

    post '/sources' do
      identifier = Identifier.new(name: params[:identifier], root_url: params[:rootUrl])

      if identifier.save
        body "{\"identifier\":\"#{params[:identifier]}\"}"
      else
        error_message = identifier.errors.full_messages.join(" ")
        status_number, message = MessageHelper.send_message(error_message)
        status status_number
        body message
      end
    end

    post '/sources/:identifier/data' do |identifier|
      unless Identifier.exists?(name: identifier)
        return status(403), body("403 Forbidden - Application URL not registered")
      end

      unless params[:payload]
        return status(400), body("Missing Payload - 400 Bad Request")
      end

      payload_hash = JSON.parse(params[:payload])
      ip = payload_hash["ip"]
      date = payload_hash["requestedAt"]

      if PayloadHelper.have_ip?(ip) && PayloadHelper.have_req_at?(date)
        return status(403), body("403 Forbidden - Payload Exists")
      end

      PayloadHelper.add_payload(identifier, payload_hash)

      status(200)
    end

    get '/sources/:identifier/urls/:path' do |identifier, path|

      website = Identifier.find_by(name: params[:identifier]).root_url
      full_url = "http://#{website}/#{path}"

      if Url.exists?(address: full_url)
        @longest_response_time = Url.longest_response_time(full_url)
        @shortest_response_time = Url.shortest_response_time(full_url)
        @average_response_time = Url.average_response_time(full_url)
        @request_types = Url.request_types(full_url)
        @referrers = Url.popular_referrers(full_url)
        @user_agent_browser = Url.popular_user_agent_browser(full_url)
        @user_agent_platform = Url.popular_user_agent_platform(full_url)
      else
        return status(403), body("403 Forbidden - Application URL not registered")
      end

      erb :unique_urls
    end

    get '/sources/:identifier/events' do |identifier|
      unless Identifier.exists?(name: identifier)
        return status(403), body("403 Forbidden - Application URL not registered")
      end
      @identifier = identifier
      @most_received_events = Identifier.find_by(name: identifier).payloads
                              .group(:event_id).count(:event_id).sort_by {|key,value| value}.reverse
      erb :events
    end

    get '/sources/:identifier/events/:event_name' do
      @visitor = Identifier.find_by(name: params[:identifier])
      unless @visitor.payloads.to_a.map(&:event).uniq.map(&:name).include?(params[:event_name])
        return erb(:no_events_error)
      end
      events_overview = Event.find_by(name: params[:event_name])
      @event_name = params[:event_name]
      @event_occurences = events_overview.payloads.where(identifier_id: @visitor.id).count
      @event_time = events_overview.payloads.where(identifier_id: @visitor.id).group_by {|hour| Time.parse(hour.requested_at).strftime("%I%p")}
      erb :event_details
    end

    not_found do
      erb :error
    end

    get '/sources/:identifier' do |identifier|
      unless Identifier.exists?(name: identifier)
        return status(403), body("403 Forbidden - Application URL not registered")
      end

      @identifier = identifier
      @urls_by_popularity = Identifier.find_by(name: identifier).payloads
                            .group(:url_id).count(:url_id).sort_by { |key, value| value}.reverse
      @urls_by_response_time = Identifier.find_by(name: identifier).payloads
                               .group(:url_id).average(:responded_in).sort_by { |key, value| value }
      @identifier_specific_payloads = Identifier.find_by(name: identifier).payloads.to_a|| []
      @paths = @urls_by_popularity.map do |url_id|
        Url.find_by(id: url_id[0]).address[/.com.+/][4..-1]
      end
      erb :application_details
    end
  end
end
