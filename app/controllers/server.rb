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
      @id = identifier
      # binding.pry
      @source = Source.find_by(:identifier == identifier)

      @urls_count = @source.list_urls
      # binding.pry
      @response_time_count = @source.list_response_times

      # x = @source
      erb :source_page
    end

    not_found do
      erb :error
    end
  end
end
