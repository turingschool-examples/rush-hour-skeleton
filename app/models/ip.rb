class Ip < ActiveRecord::Base
  has_many :payload_requests
  has_many :clients, through: :payload_requests

  validates :value, presence: true, uniqueness: true
end
