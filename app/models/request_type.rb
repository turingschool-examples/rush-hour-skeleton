class RequestType < ActiveRecord::Base
  validates :request_type, presence: true
end