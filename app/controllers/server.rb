# require_relative '../models/source'
require 'pry'
require 'byebug'

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

      # payload = Payload.find_by
      # source_id = Source.find_by(:identifier == identifier).id
      # payload.update_attributes
    end

    get '/sources/:identifier' do |identifier|
      if Source.exists?(:identifier => identifier)
        @id = identifier
        @source = Source.find_by(:identifier == identifier)
        # binding.pry
        @urls_count =@source.list_urls
        @response_time_count = @source.list_response_times
        @resolution_count = @source.list_resolution
        @browser_breakdown = @source.browser_breakdown
        @os_breakdown = @source.os_breakdown
        erb :source_page
      else
        erb :error
      end
    end

    get '/sources/:identifier/urls/*' do |identifier, splat|
      @id = identifier
      @source = Source.find_by(:identifier == identifier)
      erb :url_stats
    end

    get '/sources/:identifier/events' do |identifier|
      @id = identifier
      @events = @source.list_events
      erb :events
    end


    get '/sources/:identifier/events/:event_name' do |identifier, event_name|
      @id = identifier
      @event_name = event_name
      @source = Source.find_by(:identifier == identifier)
      @event_by_hour = @source.event_by_hour(@event_name)
      @all_hours = ((1..12).to_a.zip(("am "*12).split(" ")).map(&:join) + (1..12).to_a.zip(("pm "*12).split(" ")).map(&:join))
     @hour_breakdown = @source.count_events_by_hour(@event_name)
      erb :event_index
    end

    not_found do
      erb :error
    end


  end
end
