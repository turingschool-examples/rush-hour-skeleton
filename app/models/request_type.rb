class RequestType < ActiveRecord::Base
  has_many :payloads
  validates :verb, presence: true
end
