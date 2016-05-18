class Ip < ActiveRecord::Base
  has_many :payload_requests

  validates :value, presence: true
end
