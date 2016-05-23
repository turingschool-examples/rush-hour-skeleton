module ClientHelper

  def find_client(identifier)
    Client.find_by(identifier: identifier)
  end

  def find_urls_from_a_payload_requests(identifer, relativepath)
    @client = find_client(identifier)
    url = "http://#{identifier}.com/#{relativepath}"
    @requested_url = @client.find_urls_by_relative_paths(url)
  end

end
