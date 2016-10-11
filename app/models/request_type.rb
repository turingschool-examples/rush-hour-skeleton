class RequestType < ActiveRecord::Base

  has_many :payloads

  validates :request_type, presence: true

  def self.all_http_verbs
    # Payload.pluck(:request_type_id).uniq.reduce([]) do |r, id|
    #   r << RequestType.find(id).request_type
    #   r
    # end
    RequestType.pluck(:request_type).uniq
  end
end
