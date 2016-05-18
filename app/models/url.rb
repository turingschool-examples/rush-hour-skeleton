class Url < ActiveRecord::Base
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :referrers, through: :payload_requests
  validates :name, presence: true

  def associated_verbs
    request_types.pluck("verb")
  end

  def top_three_referrers

  end
end
