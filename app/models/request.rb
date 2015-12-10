class Request < ActiveRecord::Base
  validates :request_hash, presence: true, uniqueness: true
  belongs_to :application, :url
end
