class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :user_agents, through: :payload_requests

  validates :identifier, presence: true
  validates :rootUrl, presence: true

end
