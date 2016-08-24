class Urls < ActiveRecord::Base
  validates :url, presence: true
end