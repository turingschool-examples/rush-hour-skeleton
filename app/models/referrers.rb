class Referrer < ActiveRecord::Base
  validates :payload_request, presence: true

  has_many :payload_requests
end
