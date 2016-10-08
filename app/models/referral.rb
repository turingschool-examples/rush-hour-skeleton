class Referral < ActiveRecord::Base
  validates :source, presence: true

  has_many :payloads
end
