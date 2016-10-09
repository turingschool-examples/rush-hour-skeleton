class Referral < ActiveRecord::Base
  validates :source, presence: true
  validates :source, uniqueness: true

  has_many :payloads

  
end
