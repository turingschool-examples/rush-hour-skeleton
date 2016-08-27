module RushHour
  class Server < Sinatra::Base
    post '/sources' do
      # raw_data = params[:client]
      # parsed_data = DataParser thing
      # client = Client.new(parsed_data)
      client = Client.new(params[:client])
      if Client.find_by(params[:client])
        status 403
        body "Identifier Already Exists"
      elsif client.save
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
