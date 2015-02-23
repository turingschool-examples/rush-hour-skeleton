class RequestType < ActiveRecord::Base
  validates :http_verb, presence: true

  has_many :payloads
end
