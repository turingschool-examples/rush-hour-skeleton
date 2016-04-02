class Resolution < ActiveRecord::Base
  validates :width, presence: true
  validates :height, presence: true

  def self.all_resolutions
    self.distinct.pluck(:width, :height)
  end
end
