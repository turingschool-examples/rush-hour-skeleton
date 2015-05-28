require 'uri'
module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      result = TrafficSpy::ClientCreator.new(params)
      status result.status
      result.body
    end

    post '/sources/:id/data' do |id|
      client = Client.where(identifier: id)
      # require 'pry'; binding.pry
      result = PayloadCreator.new(params[:payload], client)
      status  result.status
      result.body
    end
  end
end
