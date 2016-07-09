class Parameter < ActiveRecord::Base
  has_many :payload_requests
  has_many :clients, through: :payload_requests

  # validates :user_input, presence: true, uniqueness: true
end
