class Referral < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :payload_requests

  def self.return_all_referrals
    pluck(:name)
  end
end
