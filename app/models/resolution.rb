class Resolution < ActiveRecord::Base
  has_many :payloads
  has_one :source, through: :payloads

  validates :resolution_width, presence: true, uniqueness: true
  validates :resolution_height, presence: true, uniqueness: true

  def resolution_size(source)
    source.resolutions.uniq
  end
end
