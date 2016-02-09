class ReferredBy < ActiveRecord::Base
  has_many :payloads
  validates :ReferredBy, presence: true
end
