class UserAgent < ActiveRecord::Base
  validates :brower, presence: true
end
