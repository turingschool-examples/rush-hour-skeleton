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
      erb :index
    end

    post '/sources' do
      validator = SourceValidator.new
      validator.validate(params)
      status validator.status
      body validator.message

      # source = Source.new(rootUrl: params[:rootUrl], identifier: params[:identifier])
      # if source.save
      #   {identifier: source.identifier}.to_json
      # elsif source.errors.full_messages.include?("Identifier has already been taken")
      #   status 403
      #   "identifier already exists"
      # else
      #   status 400
      #   "missing a parameter ya doofus"
      # end
    end

    post '/sources/:identifier/data' do |identifier|
      something = PayloadValidator.new(params, identifier)
      something.validate
      status something.status
      body something.message
    end

    not_found do
      erb :error
    end
  end
end

