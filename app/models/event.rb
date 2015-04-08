class Event < ActiveRecord::Base
 has_many :payloads 

 validates :eventName, presence: true, uniqueness: true
  
end