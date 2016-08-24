class Referral < ActiveRecord::Base
  has_many :payload_requests

  validates :referred_by, presence: true
  validates :referred_by, uniqueness: true
end
