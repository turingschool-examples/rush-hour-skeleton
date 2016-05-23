class RushHourApp < Sinatra::Base

  not_found do
    erb :error
  end

  post '/sources' do
    ca = ClientAnalyzer.new(params)
    new_param = ca.parse_client_params
    client = Client.new(new_param)

    if client.valid_params(new_param) == true
      status 403
      body "Client already exists."
    elsif client.save
      status 200
      body "Client creation successful!"
    else
      status 400
      body "Client identifier or root url not provided."
    end
  end

  get '/sources/:IDENTIFIER' do |identifier|
    if client = Client.find_by(identifier: identifier)
      @requests = client.payload_request
      if @requests.count > 0
        erb :index
      else
        body "Hmm.. it seems as if no payload data has been recieved for this source."
      end
    else
      body "Hmm.. it seems as if the identifier does not exist."
    end
  end


end
