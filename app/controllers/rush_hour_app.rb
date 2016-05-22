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

  post '/sources/:identifier/data' do |identifier|

    if Client.find_by(identifier: identifier)
       Parser.parse_payload(params[:payload], identifier)
       status 200
       body Ok
    elsif PayloadRequest.find_by
      if
        status 403
        body "Payload already received"
      else
        status 400
        body "Payload is missing "
    else
      status 403
      body "Url does not exist"
    end

  end

end
