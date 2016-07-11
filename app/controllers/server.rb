        require 'pry'

module RushHour
  class Server < Sinatra::Base

  def most_urls
      urls = @client.list_urls_from_most_to_least
      urls.map do |url|
      rel_path= url.split("/").last
      new_urls =url.split("//")[1].split(".")[0] + "/urls/#{rel_path}"
    end
  end


  post '/sources' do
    client = Client.create({identifier: params["identifier"],root_url: params["rootUrl"]})
    if client.error_message.include?("can't be blank")
      status 400
      body client.error_message
    elsif client.error_message.include?("has already been taken")
      status 403
      body client.error_message
    else
      status 200
    end
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
    pass unless @client
    payload_requests = @client.payload_requests
    pass if payload_requests.empty?
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
