require 'json'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      # require 'pry'; binding.pry
      TrafficSpy::Application.create({ identifier_name: params[:identifier], root_url: params[:rootUrl] })
      status 200
      body JSON.generate(params.select { |k, v| k == 'identifier' })
    end

    not_found do
      erb :error
    end
  end
end
