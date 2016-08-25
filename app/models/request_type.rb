class RequestType < ActiveRecord::Base
  has_many :payload_requests

  validates :method, presence: true
  validates :method, uniqueness: true

  def self.list_all_verbs
    RequestType.all.pluck(:method)
  end
end
