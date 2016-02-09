class UrlRequest < ActiveRecord::Base
  validates :url, presence: true
  validates :requestType, presence: true
  validates :parameters, presence: true
end
