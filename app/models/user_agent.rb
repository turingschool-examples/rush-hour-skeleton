module RushHour
  class UserAgent < ActiveRecord::Base
    validates :browser, presence: true
    validates :os, presence: true
  end
end
