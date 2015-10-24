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
      if Validator.validate_url(identifier) == false
        erb :identifier_error

      else
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
        erb :application_details
      end
    end

    post "/sources/:identifier/data" do |identifier|
      @source = Source.find_by(identifier: identifier)
      payload = Payload.new(Validator.prepare_payload(params["payload"]))
      Validator.add_source_id(payload, @source)
      status, body = Validator.validate_payload(identifier, payload, @source)
    end

    get "/sources/:identifier/urls/:rel_path" do |identifier, rel_path|
      @source = Source.find_by(identifier: identifier)
      payload = Payload.where(source_id: @source.id)
      relative_path = "#{@source.root_url}/#{rel_path}"
      @relevant_payloads = payload.where(url: relative_path)
      erb :url_statistics
    end

    not_found do
      erb :error
    end
  end
end
