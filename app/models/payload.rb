class Payload < ActiveRecord::Base
  belongs_to :source
  validates :payhash, presence: true, uniqueness: true
end

