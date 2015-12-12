class Request < ActiveRecord::Base
  validates :request_hash, presence: true, uniqueness: true
  belongs_to :application
  belongs_to :url
  belongs_to :event
end
