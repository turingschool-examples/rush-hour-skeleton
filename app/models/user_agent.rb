module RushHour
  class UserAgent < ActiveRecord::Base
    belongs_to :payload_request

    validates :browser, presence: true
    validates :os, presence: true
  end
end
