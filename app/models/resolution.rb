class Resolution < ActiveRecord::Base
  has_many :payloads
  validates :resolutionHeight, presence: true, uniqueness: true
  validates :resolutionWidth, presence: true, uniqueness: true
end