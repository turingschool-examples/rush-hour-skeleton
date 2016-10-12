class Resolution < ActiveRecord::Base
  has_many :payload

  validates :width, presence: true
  validates :height, presence: true
end
