class Request < ActiveRecord::Base
  has_many :payloads
  validates :requestType, presence: true, uniqueness: true
end