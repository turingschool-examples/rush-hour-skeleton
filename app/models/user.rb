class User < ActiveRecord::Base

	has_many :payloads


	validates :identifier, presence: true, uniqueness: true
	validates :rootUrl, presence: true
end