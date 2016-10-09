class Client < ActiveRecord::Base
  
  has_many :payloads
  
  validates :identifier, presence: true
  validates :root_url, presence: true
  
end