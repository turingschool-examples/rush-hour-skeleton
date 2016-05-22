class RequestedAt < ActiveRecord::Base
  has_many :payload_requests
  has_many :clients, through: :payload_requests

  validates :time, presence: true, uniqueness: true

  def hour
    Time.zone = "UTC"
    Time.zone.parse(time).hour
  end

end
