class Payload < ActiveRecord::Base
  # validates :identifier, presence: true, uniqueness: true
  belongs_to :user, :resolution
  # belongs_to :
end
