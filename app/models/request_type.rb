class RequestType < ActiveRecord::Base
  # validates :verb,      presence: true
  validates :verb, presence: true, uniqueness: true

  has_many :payload_requests
end
