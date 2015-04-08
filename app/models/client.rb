class Client < ActiveRecord::Base
  belongs_to :payload
  
  validates :identifier, presence: true, uniqueness: true
  validates :rootUrl, presence: true
end