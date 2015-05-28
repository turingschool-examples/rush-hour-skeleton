# require_relative '../models/source'

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
      source = TrafficSpy::Source.new(params)
      if source.save
        {identifier: source.identifier}.to_json
      elsif source.errors.full_messages == ["Identifier has already been taken"]
        status 403
        "identifier already exists"
      else
        # source.errors.full_messages == ["Rooturl can't be blank"]
        status 400
        "missing a parameter ya doofus"
      end
    end

    not_found do
      erb :error
      status 403
      body "source not created, missing parameters"
    end
  end
end
