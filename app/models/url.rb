class Url < ActiveRecord::Base
  validates :address, :referral_id,
            presence: true
  belongs_to :referrals
  has_many :payload_requests
end
