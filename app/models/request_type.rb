class RequestType < ActiveRecord::Base
  validates :verb, presence: true, uniqueness: true
  has_many :payload_requests

  def self.all_http_verbs_used
    pluck(:verb)
  end
end
