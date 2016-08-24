class RequestTypes < ActiveRecord::Base
  validates :request_type, presence: true
end