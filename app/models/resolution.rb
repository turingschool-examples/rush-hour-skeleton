class Resolution < ActiveRecord::Base

  has_many :payloads

  validates :resolution_width, presence: true
  validates :resolution_height, presence: true
end
