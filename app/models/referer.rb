class Referer < ActiveRecord::Base
  has_many :payloads
  validates :referredBy, presence: true, uniqueness: true
end