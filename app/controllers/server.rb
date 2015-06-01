require_relative '../models/source_creator'
require 'json'

module TrafficSpy
  class Server < Sinatra::Base
    
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      response = SourceCreator.new(params)
      status(response.status)
      body(response.body)
    end

    post "/sources/:identifier/data" do |identifier|
      response = PayloadCreator.new(params[:payload], identifier)
      status(response.status)
      body(response.body)
    end

    get "/sources/:identifier" do |identifier|
      if Source.where(identifier: identifier).exists?
        @source = Source.find_by(identifier: identifier)
        erb :dashboard
      else
        message = "ERROR: Identifier doesn't exist."
        redirect to("/?message=#{message}")
      end
    end

    get "/sources/:identifier/urls/*" do |identifier, splat|
      @source = Source.find_by(identifier: identifier)
      @url = @source.root_url + "/" + splat
      if @source.grouped_urls.exists?(url: @url)
        erb :urls
      else
        message = "ERROR: URL has not been requested."
        redirect to("/?message=#{message}")
      end
    end

    get "/sources/:identifier/events" do |identifier|
      @source = Source.find_by(identifier: identifier)
      erb :events
    end

    get "/sources/:identifier/events/:event_name" do |identifier, event_name|
      @source = Source.find_by(identifier: identifier)
      @event_name = event_name
      erb :event_details
    end
    
    helpers do
      def anchor(url, text)
        "<a href=#{url}>#{text}</a>"
      end
    end
  end
end

