class RequestType < ActiveRecord::Base
  validates :name, presence: true
end
