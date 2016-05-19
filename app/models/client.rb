class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :user_agent, through: :payload_requests

    validates :url,           presence: true
    validates :identifier,    presence: true
end
