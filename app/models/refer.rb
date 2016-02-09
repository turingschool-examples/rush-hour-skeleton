class Refer < ActiveRecord::Base
  has_many :payloads
  validates :referredBy, presence: true
end
