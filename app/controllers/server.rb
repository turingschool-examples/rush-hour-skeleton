module RushHour
  class Server < Sinatra::Base

    get '/sources' do
      erb :sources_index
    end

    post '/sources' do
      status, body = ClientParser.new.parse_client(params)
    end

    post '/sources/:identifier/data' do
      status, body = PayloadParser.new.parse_payload(params)
    end

    get '/sources/:identifier' do |identifier|
      @source = Client.find_by(identifier: params[:identifier])
      if @source.nil?
        erb :no_identifier_found
      elsif @source.payloads.all.empty?
        erb :missing_payload
      else
        erb :analytics_dashboard
      end
    end


    not_found do
      erb :error
    end
  end
end
