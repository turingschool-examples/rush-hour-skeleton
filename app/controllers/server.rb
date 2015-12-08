require 'json'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      # binding.pry
      TrafficSpy::Application.create({ identifier_name: params[:applications][:identifier], root_url: params[:applications][:rootUrl] })
      status 200
      body JSON.generate(params[:applications].select { |k, v| k == 'identifier' })
    end

    not_found do
      erb :error
    end
  end
end
