class User < ActiveRecord::Base
  validates_presence_of :identifier
end
