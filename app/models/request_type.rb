class RequestType < ActiveRecord::Base
  validates :verb,   presence: true
  validates :verb,   uniqueness: true

  has_many :payload_requests
  has_many :clients, through: :payload_requests

  def self.sorted_list_of_http_verbs_used
    joins(:payload_requests).group("request_types.verb").order(count: :desc).count.keys
  end
end
