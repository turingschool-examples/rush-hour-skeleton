module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    get '/' do

    end

    get '/sources' do
      @clients = Client.all

    end

    post '/sources' do
      client = Client.new("identifier" => params[:identifier], "root_url" => params[:rootUrl])
      if params[:identifier].nil? || params[:rootUrl].nil?
        status 400
        body "Bad Request: Please include both an identifer and root url."
      elsif Client.exists?(:identifier => params[:identifier])
        status 403
        body "Forbidden: That identifier is already in use. Please choose a new identifier."
      else
        client.save
        status 200
        body "Success: {'identifier':#{params[:identifier]}}"
      end

    end

    post '/sources/:identifier/data' do
      parsed_data = Payload.create(parser(params[:payload]))
      if Payload.exists?(responded_in: parsed[:responded_in], requested_at: parsed[:requested_at], url_id: url.id, ...  )
        return error
      else
        Payload.create(parsed_data)
      end
    end

    def parser(data)
      parsed_data = JSON.parse(data)

      final_hash = {}
      parsed_data.each do |key, value|
        final_hash[to_snake_case(key)] = value
      end

    end

    def to_snake_case(string)
      string.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end

  end
end
