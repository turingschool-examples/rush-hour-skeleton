class ReferrerUrl < ActiveRecord::Base
  validates :url_address, presence: true
  has_many :payload_requests
end
