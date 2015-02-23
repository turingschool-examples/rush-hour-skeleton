class Resolution < ActiveRecord::Base

	has_many :payloads
	validates :resolutionWidth, presence: true
	validates :resolutionHeight, presence: true
	validates_uniqueness_of :resolutionHeight, :scope => :resolutionWidth

end
