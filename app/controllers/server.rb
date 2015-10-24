module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources' do
      erb :sources
    end

    post '/sources' do
      source = Source.new(identifier: params[:identifier], root_url: params[:rootUrl])
      status, body = Validator.validate_source(source)
      # is status the status we assigned to this variable? and body the right body for this variable? are these being sent back to the user?
    end

    get "/sources/:identifier" do |identifier|
      @source = Source.where(identifier: identifier).first
      payload = Payload.where(source_id: @source.id)
      @url_counts = payload.group(:url).count.sort_by { |url, count| count }.reverse
      agents = payload.map do |payload|
        payload.user_agent
      end
      browsers = agents.inject(Hash.new(0)) {|browser, count| browser[count] += 1; browser}.sort
      @browser_counts = browsers.map do |user_agent, count|
        [UserAgent.parse(user_agent).browser, count]
      end
      os = agents.inject(Hash.new(0)) {|os, count| os[count] += 1; os}.sort
      @os_counts = browsers.map do |user_agent, count|
        [UserAgent.parse(user_agent).platform, count]
      end
      @resolutions = payload.group(:resolution_height).sort_by { |resolution_height| resolution_height }.reverse
      @response_times = payload.group(:responded_in).sort_by { |responded_in| responded_in }.reverse
      erb :application_details

      # skinny controllers, fat models - get most of this logic to happen in the models. refactor this and have the source be
      # the only thing that goes to the views. make these instance variables methods that we call on @source (@source.url_counts) etc.
    end

    post "/sources/:identifier/data" do |identifier|
      @source = Source.find_by(identifier: identifier)
      payload = Payload.new(Validator.prepare_payload(params["payload"]))
      status, body = Validator.validate_payload(identifier, payload, @source)
    end

    not_found do
      erb :error
    end
  end
end
