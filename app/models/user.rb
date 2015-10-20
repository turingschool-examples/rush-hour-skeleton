class User < ActiveRecord::Base
  validates_presence_of :identifier
  validates_presence_of :rootUrl
end
