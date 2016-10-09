class Agent < ActiveRecord::Base

  has_many :payloads

  validates :agent, presence: true
end
