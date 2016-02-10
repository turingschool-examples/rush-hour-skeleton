class Resolution < ActiveRecord::Base
  has_many :payloads
  validates :width, presence: true
  validates :height, presence: true
end
