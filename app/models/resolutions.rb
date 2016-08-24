class Resolutions < ActiveRecord::Base
  validates :height, :width, presence: true
end