class Verb < ActiveRecord::Base
  has_many :payload_requests

  validates :request_type, presence: true, uniqueness: true

  def self.list_verbs
    pluck(:request_type)
  end
end
