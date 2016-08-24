class Resolution < ActiveRecord::Base
  validates :height, presence: true
  validates :width, presence: true
end
