class Resolution < ActiveRecord::Base
  has_many :payloads
  validates :resolutionWidth, presence: true
  validates :resolutionHeight, presence: true
end
