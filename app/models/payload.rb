class Payload < ActiveRecord::Base
  validates :requested_at, uniqueness: true, presence: true
end
