class UserAgent < ActiveRecord::Base

  validates :user_agent, presence: true

end
