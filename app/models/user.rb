class User < ActiveRecord::Base
  has_many :payloads 

  validates_presence_of :identifier
  validates_presence_of :rootUrl

end
