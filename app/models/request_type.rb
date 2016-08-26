class RequestType < ActiveRecord::Base
  has_many :payload_requests

  validates :http_verb, presence: true
  validates :http_verb, uniqueness: true

  def self.list_all_verbs
    RequestType.pluck(:http_verb)
  end

  def self.most_frequent_request
    PayloadRequest.join(:request_types).group(:http_verb)
  end
end
