class Request < ActiveRecord::Base
  has_many :payloads
  validates :request_type, presence: true, uniqueness: true
end
