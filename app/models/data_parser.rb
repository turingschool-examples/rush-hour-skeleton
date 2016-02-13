require 'json'
require_relative './client'

class DataParser
  def parse_client(params)
    if params.has_key?("identifier") && params.has_key?("rootUrl") && !params["identifier"].nil?
      new_identifier  = params["identifier"]
      root_url         = params["rootUrl"]
      client = create_client(new_identifier, root_url)

      binding.pry
      if client.save
        [200, {"identifier": "#{new_identifier}"}.to_json]
      else
        [403, "Please choose an identifier that's not already in use."]
      end
    else
      [400, "Please provide both an identifer and root url parameter."]
    end
  end

  def create_client(new_identifier, root_url)
    Client.where(:identifier => new_identifier).first_or_create do |client|
      client.root_url = root_url
    end
  end
end
