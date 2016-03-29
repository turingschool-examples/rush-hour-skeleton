class ResponseTime < ActiveRecord::Base
  validates :time, presence: true
end
