class User < ActiveRecord::Base

	has_many :sessions


	validates :identifier, presence: true, uniqueness: true
	validates :rootUrl, presence: true

end