module UrlRequestHelper
  def self.find_url(identifier, path)
    client = ClientHelper.find_client(identifier)
    @url   = UrlRequest.find_by(url: client.root_url + "/#{path}")
  end
end
