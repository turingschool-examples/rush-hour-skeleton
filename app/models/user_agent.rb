class UserAgent < ActiveRecord::Base

  has_many :payloads

  validates :user_agent, presence: true
end
