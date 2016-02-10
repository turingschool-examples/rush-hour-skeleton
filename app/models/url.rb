class Url < ActiveRecord::Base
  has_many :payloads
  validates :route, presence: true

  def max_response_time
    payloads.maximum(:responded_in)
  end

  def min_response_time
    payloads.minimum(:responded_in)
  end

  def ranked_response_times
    payloads.order(responded_in: :desc).pluck(:responded_in)
  end

  def average_response_time
    payloads.average(:responded_in)
  end

  def associated_verbs
    request_payloads = payloads.select(:request_type_id).distinct
    request_payloads.map do |rp|
      RequestType.find_by(id: rp.request_type_id).verb
    end
  end
end
