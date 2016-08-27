require_relative '../models/data_parser' # <= this doesn't work yet

module RushHour
  class Server < Sinatra::Base
    post '/sources' do
      # p params
      # p params["rootUrl"]
      # actual_params = {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}

      # parsed_data = DataParser thing
      # client = Client.new(parsed_data)
      # client = Client.new(params[:client])

      client_data = DataParser.new(params)
      parsed_client = client_data.formatted_client
      client = Client.new(parsed_client)
      if Client.exists?(identifier: params["identifier"])
        status 403
        body "Identifier Already Exists"
      elsif client.save
        "{'identifier':'#{params['identifier']}'}"
        status 200
        body "Success!"
      else
        status 400
        body "Missing Parameters"
      end
    end

    not_found do
      erb :error
    end
  end
end

# post '/items' do
#   item = Item.new(params[:item])
#   if item.save
#     status  200
#     body  "Item created"
#   else
#     status  400
#     body  item.errors.full_messages.join(", ")
#   end
# end
