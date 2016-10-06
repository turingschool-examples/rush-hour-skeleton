module RushHour
  class Server < Sinatra::Base

  helpers do
    def most_urls
        urls = @client.list_urls_from_most_to_least
    end
    
    # Write the rest of your controller code here!
  end

  post '/sources' do
    client = Client.create({identifier: params["identifier"],root_url: params["rootUrl"]})
    result = DataLoader.error_check(client)
    body result[:body]
    status result[:status]
  end

  post '/sources/:identifier/data' do
    parsed_payload = Parser.parse_payload(params["payload"])
    result = DataLoader.load(parsed_payload, params["identifier"])

    status result[:body]
    status result[:status]
  end

  get '/sources/:identifier' do |identifier|
    @identifier = identifier

    @client = Client.find_by(identifier: identifier)
    payload_requests = @client.payload_requests
    erb :dashboard
  end

  get '/sources/:identifier/urls/:rel_path' do |identifier, rel_path|
     @rel_path = rel_path; @identifier = identifier
     client = Client.find_by(identifier: identifier)
     url = client.find_url_by_relative_path(rel_path)
     pass unless url
     erb :url_dashboard, locals: { url: url }
   end

   get '/sources/:identifier/urls/*' do |identifier, splat|

     error_message = "No Data for #{splat} for #{identifier.capitalize}"
     erb :error, locals: { error_message: error_message }
   end
  end
end
