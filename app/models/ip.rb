class Ip < ActiveRecord::Base
  has_many :payload_requests

  validates :ip, presence: true
  validates :ip, uniqueness: true
end
