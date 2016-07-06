class Referral < ActiveRecord::Base
  validates :name, presence: true
  has_many :payload_requests
end
