class RequestType < ActiveRecord::Base
  has_many :payload_requests
  has_many :urls, through: :payload_requests

  validates :verb, presence: true
end
