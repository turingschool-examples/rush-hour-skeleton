class Client < ActiveRecord::Base

  has_many :events
  has_many :urls
  has_many :user_agents

  validates :name, presence: true
  validates_uniqueness_of :name, message: "%{value} already taken."
  validates :root_url, presence: true

end
