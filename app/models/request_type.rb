class RequestType < ActiveRecord::Base
  validates :verb, presence: true
end
