class Request < ActiveRecord::Base
  validates :verb, presence: true

  has_many :payload_requests

  
end
