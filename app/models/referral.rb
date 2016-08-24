class Referral < ActiveRecord::Base
  validates :referred_by, presence: true
end