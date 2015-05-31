# require_relative '../models/source'
require 'pry'
require 'byebug'
require 'uri'

module TrafficSpy
  class Server < Sinatra::Base

    # register Sinatra::Partial
    # set :partial_template_engine, :erb
    #
    # helpers do
    #   def image_tag(url, alt)
    #     "<img src='#{url}' alt='#{alt}' />"
    #   end
    #
    #   def date_object_parser_thing
    #
    #   end
    # end

    get '/' do
      erb :dashboard
    end

    get '/sources' do
      @sources = Source.all
      erb :index
    end

    post '/sources' do
      validator = SourceValidator.new
      validator.validate(params)
      status validator.status
      body validator.message
    end

    post '/sources/:identifier/data' do |identifier|
      validator = PayloadValidator.new(params[:payload], identifier)
      validator.validate
      status validator.status
      body validator.message
    end

    get '/sources/:identifier' do |identifier|
      if Source.exists?(:identifier => identifier)
        @id = identifier
        @source = Source.find_by(:identifier == identifier)
        # binding.pry
        @urls_count = @source.list_urls
        @response_time_count = @source.list_response_times
        @resolution_count = @source.list_resolution
        @browser_breakdown = @source.browser_breakdown
        @os_breakdown = @source.os_breakdown
        @events = @source.list_events
        erb :source_page
      else
        erb :error
      end
    end

    get '/sources/:identifier/urls/*' do |identifier, splat|
      if Payload.exists?(:url => url)
        @id = identifier
        @splat = splat
        @source = Source.find_by(:identifier == identifier)
        @url = @source.root_url + '/' + splat
        @message = "alsdjflkajsdlkfjlkasdjkfljskj"
        erb :url_stats
      else
        erb :url_error
      end
    end

    get '/sources/:identifier/events' do |identifier|
      @id = identifier
      @source = Source.find_by(:identifier == identifier)
      @events = @source.list_events
      if @events.keys.count == 0
        erb :events_error
      else
        erb :events
      end
    end

    get '/sources/:identifier/events/:event_name' do |identifier, event_name|
      if Payload.exists?(:event_name => event_name)
        @id = identifier
        @event_name = event_name
        @source = Source.find_by(:identifier == identifier)
        @source.event_hour_breakdown(@event_name)
        erb :event_index
      else
        erb :event_name_error
      end
    end

    not_found do
      erb :error
    end


  end
end
