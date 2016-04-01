class Resolution < ActiveRecord::Base
  validates :width, presence: true
  validates :height, presence: true

  def self.all_resolutions
    # join payloads?
    self.distinct.pluck(:width, :height)
    # .map do |pair|
    #   "#{pair[0]} x #{pair[1]}"
    # end
  end
end
