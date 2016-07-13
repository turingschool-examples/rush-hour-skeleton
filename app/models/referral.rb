class Referral < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :payload_requests
end
