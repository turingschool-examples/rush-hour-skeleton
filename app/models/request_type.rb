class RequestType < ActiveRecord::Base

  has_many :payloads

  validates :requestType, presence: true
end
