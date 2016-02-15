module RushHour
  class Server < Sinatra::Base

    not_found do
      erb :error
    end

    def render_payload_requests(client)
      if client.payload_requests.empty?
        erb :app_error, locals: { msg: "No payload data has been received for this source." }
      else
        erb :statistics
      end
    end

    post '/sources' do
      ClientHelper.parse_client_params(params)
    end

    get '/sources/:identifier' do |identifier|
      @client = ClientHelper.find_client(identifier)

      if @client.nil?
        erb :app_error, locals: { msg: "Identifier does not exist" }
      else
        render_payload_requests(@client)
      end
    end

    post '/sources/:identifier/data' do |identifier|
      client = ClientHelper.find_client(identifier)
      return ApplicationHelper.status_message(403, "403 Forbidden - Application not registered") unless client

      payload_request = PayloadRequestHelper.create_payload_request(client, params)
      PayloadRequestHelper.payload_status_message(params, payload_request)
    end

    get '/sources/:identifier/events' do |identifier|
      @client = ClientHelper.find_client(identifier)
      erb :event_index
    end

    get '/sources/:identifier/events/:event' do |identifier, event|
      @client = ClientHelper.find_client(identifier)
      @event  = event
      if @client.payload_requests.find_by(event_name: event)
        erb :event_show
      else
        erb :event_error
      end
    end

    get '/sources/:identifier/urls' do |identifier|
      @client = ClientHelper.find_client(identifier)
      urls = @client.url_requests.pluck(:url).uniq
      erb :urls, locals: { urls: urls }
    end

    get '/sources/:identifier/urls/:path' do |identifier, path|
      @url = UrlRequestHelper.find_url(identifier, path)
      if @url
        erb :url_stats
      else
        erb :url_does_not_exist
      end
    end
  end
end
