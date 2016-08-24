class UserAgent < ActiveRecord::Base
  validates :browser, :operating_system, presence: true
end