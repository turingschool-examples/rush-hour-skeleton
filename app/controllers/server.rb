
module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end



    post '/sources' do
      source = Source.new(params)
      return_value = Hash.new
      return_value['identifier'] = source.identifier
      if source.save
        status 200
        body "#{return_value}"
      else
        status 400
        "missing parameters"
      end
    end

    not_found do
      erb :error
    end
  end
end
