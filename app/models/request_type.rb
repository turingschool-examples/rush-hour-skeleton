class RequestType < ActiveRecord::Base

  has_many :payloads

  validates :request_type, presence: true

  def self.all_http_verbs
    RequestType.pluck(:request_type).uniq
  end
end
