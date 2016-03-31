require_relative '../models/check_client_params'
require 'pry'


module RushHour
  class Server < Sinatra::Base
    include CheckClientParams

    post '/sources' do

      client = Client.new(params)
      client = Client.new(identifier: params[:identifier], root_url: params[:rootUrl])

      client.save if check(params)
    end

    not_found do
      erb :error
    end
  end
end
