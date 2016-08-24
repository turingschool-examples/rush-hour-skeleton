class RequestType < ActiveRecord::Base
  has_many :payload_requests

  validates :method, presence: true
  validates :method, uniqueness: true
end
