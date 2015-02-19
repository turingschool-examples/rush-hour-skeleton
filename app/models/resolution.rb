class Resolution < ActiveRecord::Base

	validates :resolutionWidth, presence: true
	validates :resolutionHeight, presence: true

end
