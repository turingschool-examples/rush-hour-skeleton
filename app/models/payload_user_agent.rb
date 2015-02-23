class PayloadUserAgent < ActiveRecord::Base
  validates :browser, :os, presence: true

  has_many :payloads
end
