require 'digest'
require 'byebug'
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
      # status SourceResponder.new(params).status
      # body SourceResponder.new(params).body

      source_data = { identifier: params["identifier"],
                      root_url: params["rootUrl"] }

      if Source.exists?(source_data)
        status 403
        body "Identifier already exists"
      else

        @source = Source.new(source_data)
        if @source.save
          hash = {identifier: @source.identifier}
          body hash.to_json
        else
          status 400
          body "Missing parameter, the required parameters are 'identifier' and 'rootUrl'"
        end
      end
    end

    post '/sources/:identifier/data' do |identifier|
      # status PayloadResponder.new(params).status
      # body PayloadResponder.new(params).body

      if Source.exists?(identifier: identifier)
        sha = Payload.generate_sha(params.values.join)
        if Payload.exists?(sha: sha)
          status 403
          body "Duplicate payload detected!"
        elsif params[:payload].blank?
          status 400
          body "Payload missing"
        else
          payload = params['payload']
         # payload = { "payload" => JSON.parse(payload) }
          # create ParamsParser class for all of these
          payload = JSON.parse(payload)
          url = payload['url']
         # url = JSON.parse(params[:payload])['url']
          Payload.create({sha: sha})
          Page.create({url: url}) 
          body "success"
        end
      else
        status 403
        body "Application not registered"
      end
    end

    #  When an identifer exists return a page that displays the following:
    #  Most requested URLS to least requested URLS (url)
    
    get '/sources/:identifier' do |identifier|
      if Source.exists?(identifier: identifier)

        status 200    
        erb :index 
      else
        @error = "#{identifier} does not exist!"
        status 404
        erb :error
      end
    end
  end
end
