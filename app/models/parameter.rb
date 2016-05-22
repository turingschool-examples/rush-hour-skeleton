class Parameter < ActiveRecord::Base
  has_many :payload_requests
  has_many :clients, through: :payload_requests

  validates :list, presence: true, uniqueness: true
end
