class Ips < ActiveRecord::Base
  validates :ip, presence: true
end