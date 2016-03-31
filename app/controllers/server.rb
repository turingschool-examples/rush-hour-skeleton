require_relative '../models/params_checker'

module RushHour
  class Server < Sinatra::Base
    include ParamsChecker

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
