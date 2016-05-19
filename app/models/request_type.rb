class RequestType < ActiveRecord::Base
  has_many :payload_requests
  has_many :urls, through: :payload_requests

  validates :verb, presence: true, uniqueness: true

  def self.list_of_verbs_used
    pluck("verb")
  end

end
