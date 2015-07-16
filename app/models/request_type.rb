class RequestType < ActiveRecord::Base
  validates :verb, presence: true

  has_many :payloads
end
