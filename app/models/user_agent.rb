class TrafficSpy::UserAgent < ActiveRecord::Base
  belongs_to :payload
  validates :user_agent, uniqueness: true
end
