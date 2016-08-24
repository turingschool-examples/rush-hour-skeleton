class Ip < ActiveRecord::Base
  validates :ip, presence: true
end