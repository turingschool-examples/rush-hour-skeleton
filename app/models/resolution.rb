class Resolution < ActiveRecord::Base
  validates :height, :width, presence: true
end