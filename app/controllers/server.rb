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
      erb :application_details
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
