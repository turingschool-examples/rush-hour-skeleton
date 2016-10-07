class RequestType < ActiveRecord::Base

  has_many :payloads

  validates :request_type, presence: true
end
