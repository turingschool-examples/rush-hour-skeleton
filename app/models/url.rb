class Url < ActiveRecord::Base
  validates :address, presence: true, uniqueness: true
  has_many :payload_requests

  def max_response_time
    payload_requests.maximum(:responded_in)
  end

  def min_response_time
    payload_requests.minimum(:responded_in)
  end

  def all_response_times_sorted_high_to_low
    payload_requests.order(responded_in: :desc).select(:responded_in).distinct.pluck(:responded_in)
  end

  def average_response_time
    payload_requests.average(:responded_in)
  end

  def all_http_verbs
    request_type_ids = payload_requests.pluck(:request_type_id).uniq

    request_type_ids.map { |id| RequestType.where(id: id).pluck(:verb)[0] }
  end

  def top_three_referrers
    referrer_url_id_hash = payload_requests.group(:referrer_url_id).count

    sorted_arr = referrer_url_id_hash.sort_by { |k,v| v }.reverse.first(3)

    addresses = sorted_arr.map do |elem|
      ReferrerUrl.where(id: elem[0]).pluck(:url_address)[0]
    end
  end

  def top_three_user_systems
    user_system_id_hash = payload_requests.group(:user_system_id).count

    sorted_arr = user_system_id_hash.sort_by { |k, v| v }.reverse.first(3)

    systems = sorted_arr.map do |elem|
      [UserSystem.where(id: elem[0]).pluck(:browser_type)[0], UserSystem.where(id: elem[0]).pluck(:operating_system)[0]]
    end
  end
end
