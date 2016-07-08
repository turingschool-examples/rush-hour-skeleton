class Referrer < ActiveRecord::Base
  validates :address,   presence: true
  # validates :address,  uniqueness: true

  has_many :payload_requests
end
