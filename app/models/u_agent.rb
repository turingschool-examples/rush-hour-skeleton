class UAgent < ActiveRecord::Base
  has_many :payload_requests

  validates :browser, presence: true
  validates :os, presence: true
end
