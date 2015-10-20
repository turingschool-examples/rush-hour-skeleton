class User < ActiveRecord::Base
  validates_presence_of :data_identifier
  validates_presence_of :root_url
end
