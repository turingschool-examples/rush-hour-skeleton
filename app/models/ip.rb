class Ip < ActiveRecord::Base
  has_many :payload_requests

  validates :address, presence: true
end
