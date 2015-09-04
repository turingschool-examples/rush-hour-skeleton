module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    post '/sources' do
      messenger = Messenger.new(params, "Source")
      status messenger.status
      body messenger.message
    end

    post '/sources/:identifier/data' do
      if !Source.find_by(identifier: params[:identifier])
        status 403
        body "Application Not Registered"
      elsif params[:payload].nil? || params[:payload].empty?
        status 400
        body "Missing Payload"
      else
        attributes = JSON.parse(params[:payload])
        sha_identifier = Digest::SHA1.hexdigest(params[:payload])
        attributes[:sha_identifier] = sha_identifier
        attributes[:source_id] = Source.find_by(identifier: params[:identifier]).id
        messenger = Messenger.new(attributes, "Visit")
        status messenger.status
        body messenger.message
      end
    end

    get '/sources/:identifier' do
      if source = Source.find_by(identifier: params[:identifier])
        @identifier = source.identifier.capitalize
        visits = Visit.where(source_id: source.id)
        raw_urls = visits.map {|visit| visit.url}
        @urls = raw_urls.map.with_object(Hash.new(0)) do |url, hash|
          hash[url] += 1
        end.to_a.max_by(raw_urls.count) {|url, visit_count| visit_count}
        @screen_resolutions = visits.map do |visit|
          "#{visit.resolution_width}x#{visit.resolution_height}"
        end.uniq
        #Code for BROWSER AND OS statistics below via user_agent field
        user_agents = visits.map {|visit| UserAgent.parse(visit.user_agent)}
         @browsers = user_agents.map.with_object(Hash.new(0)) do |user_agent, hash|
          hash[user_agent.browser] += 1
        end.to_a.max_by(user_agents.count) {|browser, visit_count| visit_count}

        @os_platforms = user_agents.map.with_object(Hash.new(0)) do |user_agent, hash|
         hash[user_agent.platform] += 1
       end.to_a.max_by(user_agents.count) {|os_platform, visit_count| visit_count}

        erb :show
      else
        erb :error
      end
    end

    not_found do
      erb :error
    end
  end
end
