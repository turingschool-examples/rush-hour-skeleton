class ScreenResolution < ActiveRecord::Base
  has_many :payloads
  validates :size, presence: true
end
