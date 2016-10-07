class Resolution < ActiveRecord::Base

  validates :width, presence: true
  validates :height, presence: true

end
