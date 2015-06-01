class Payload < ActiveRecord::Base
  validates :requested_at, uniqueness: true, presence: true

  belongs_to :source
end
