require './app/models/url'
require './app/models/payload_request'
class UrlPayloadRequestAnalyst

  def most_to_least_requested_url
    group_by_url.to_a.map do |frequency_url_id|
      Url.find_by(:id => frequency_url_id[1]).address
    end
  end

  def group_by_url
    PayloadRequest.group('url_id').order("url_id desc").count
  end
end
