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
    parser = Parser.new
    client = Client.find_by(identifier: identifier)
    #require 'pry';binding.pry
    # if @errors
    #   status error_status[@errors]
    #   body @errors
      if client.nil?
          status 403
          body "Url does not exist"
      elsif parser.parse_payload(params[:payload], identifier)
        @errors = parser.payload.errors.full_messages.join(", ")
        if @errors.include?("can't be blank")
          status 400
          body "Payload is missing"
        elsif @errors.include?("already been taken")
         status 403
         body "Payload already received"
        else
         status 200
         body "OK"
       end
      end
  end


  def error_status
    {"can't be blank" => 400, "key isn't unique" => 403}
  end

end
