class Payload < ActiveRecord::Base
  belongs_to :user
  has_many :ips
end