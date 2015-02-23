class Resolution < ActiveRecord::Base
  validates :resolution_height, :resolution_width, presence: true

  has_many :payloads
end
