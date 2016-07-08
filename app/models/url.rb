class Url < ActiveRecord::Base
  validates :address, :referral_id,
            presence: true

  belongs_to :referral
  has_many :payload_requests
  has_many :ips, through: :payload_requests

  def min_response_time
    payload_requests.min(:response_time)
  end

  def most_frequent_ip
    ips.group(:address)
  end

end
