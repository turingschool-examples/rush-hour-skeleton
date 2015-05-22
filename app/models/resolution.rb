class Resolution < ActiveRecord::Base
  has_many :payloads
  validates :resolution_height, presence: true, uniqueness: true
  validates :resolution_width, presence: true, uniqueness: true
end
