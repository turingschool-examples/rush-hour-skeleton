require_relative '../models/check_client_params'

module RushHour
  class Server < Sinatra::Base
    include CheckClientParams

    post '/sources' do
      client = Client.new(params[:client])

      client.save if check(params[:client])
    end




    #
    #   if client.save
    #     status 200
    #     body "Client registered"
    #   else
    #     status 401
    #     body "Fail!! You are a teapot!"
    #   end


    not_found do
      erb :error
    end
  end
end
