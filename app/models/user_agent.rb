class UserAgent < ActiveRecord::Base
  belongs_to :payload_request

  validates :user_agent, presence: true


end
