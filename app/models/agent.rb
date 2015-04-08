class Agent < ActiveRecord::Base
  has_many :payloads
  
  validates :userAgent, presence: true, uniqueness: true
end