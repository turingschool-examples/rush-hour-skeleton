class Payload < ActiveRecord::Base
  validates :digest, presence: true, uniqueness: true
end
