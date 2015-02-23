class Resolution < ActiveRecord::Base

	belongs_to :payload

	validates :resolutionWidth, presence: true
	validates :resolutionHeight, presence: true
	validates_uniqueness_of :resolutionHeight, :scope => :resolutionWidth

end
