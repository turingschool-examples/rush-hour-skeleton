class UrlRequest < ActiveRecord::Base
  has_many :payload_requests

  validates :url, presence: true
  validates :request_type, presence: true
  validates :parameters, presence: true
end
