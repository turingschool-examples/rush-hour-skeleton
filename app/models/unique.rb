require 'digest'
require 'net/http'

module Unique
  def create_sha(params)
    Digest::SHA1.hexdigest params.to_s
  end

  def client_sha_exists?(object)
    Client.exists?(sha: object.sha)
  end

  def payload_sha_exists?(object)
    PayloadRequest.exists?(sha: object.sha)
  end

  def bad_url?(params)
    parsed_payload = JSON.parse(params["payload"])

    url = URI.parse(parsed_payload["url"])
    req = Net::HTTP.new(url.host, url.port)
    res = req.request_head(url.path)

    return true if res.code != "200"
  end

end
