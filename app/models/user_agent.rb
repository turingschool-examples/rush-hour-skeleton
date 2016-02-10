class UserAgent < ActiveRecord::Base
  has_many :payloads
  validates :browser, presence: true
  validates :os, presence: true
end
