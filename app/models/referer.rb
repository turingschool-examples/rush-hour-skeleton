class Referer < ActiveRecord::Base
  has_many :payloads
  validates :referred_by, presence: true, uniqueness: true
end
