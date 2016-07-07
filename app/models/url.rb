class Url < ActiveRecord::Base
  validates :address,   presence:true

  has_many :payload_requests
end
