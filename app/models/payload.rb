class Payload < ActiveRecord::Base
  belongs_to :user
  has_many :ips
  has_many :urls
  has_many :events
end
