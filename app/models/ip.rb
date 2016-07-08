class Ip < ActiveRecord::Base
  validates :address, presence: true

  has_many :payload_requests
  has_many :clients, through: :payload_requests
end
