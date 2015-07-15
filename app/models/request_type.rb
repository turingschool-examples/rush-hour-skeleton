class RequestType < ActiveRecord::Base
  validates :verb, presence: true, uniqueness: true

  has_many :payloads
end
