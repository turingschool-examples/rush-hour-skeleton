class ReferredBy < ActiveRecord::Base

  has_many :payloads

  validates :referred_by, presence: true
end
