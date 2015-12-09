class Client < ActiveRecord::Base

  has_many :events
  has_many :urls
  has_many :user_agents
  has_many :hexed_payloads

  validates :name, presence: true
  validates :root_url, presence: true

end
