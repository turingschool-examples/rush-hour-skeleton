class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :request_types, through: :payload_requests

  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true


  def most_requested_verbs
    request_types.group(:verb).count
  end

end
