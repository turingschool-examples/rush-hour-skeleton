class Url < ActiveRecord::Base
  validates "url", presence: true

  has_many :payload_requests

  def self.max_url_response_time
    Url.payload_requests.maximum_response_time
  end


  def self.most_to_least_requested_urls
    self.order('url desc').map do |u|
      u.url
    end
  end
end
