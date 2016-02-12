require 'json'
require_relative './client'

class DataParser
  def parse_client(params)
    if params.has_key?("identifier") && params.has_key?("rootUrl")
      new_identifier  = params["identifier"]
      root_url         = params["rootUrl"]
      binding.pry
      client = Client.select(:clients).where(:identifier => new_identifier).first_or_create do |variable|
        
      end
      # client = create_client(new_identifier, root_url)
      if client.save
        [200, '{"identifier":"#{new_identifier}"}']
      else
        [403, "Please choose an identifier that's not already in use."]
      end
    else
      [400, "Please provide both a identifer and root url parameter."]
    end
  end

  def create_client(new_identifer, root_url)
    Client.select(:clients).where(:identifier => new_identifier).first_or_create do |variable|
      client.root_url = root_url
    end
  end
end
