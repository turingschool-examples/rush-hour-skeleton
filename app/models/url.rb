class Url < ActiveRecord::Base
  validates :address, presence: true, uniqueness: true
  has_many :payload_requests

  def max_response_time
    payload_requests.maximum(:responded_in)
  end

  def min_response_time
    payload_requests.minimum(:responded_in)
  end

  def all_response_times
    payload_requests.group(:responded_in).count.keys.sort.reverse
  end

  def average_response_time
    payload_requests.average(:responded_in)
  end

  def all_http_verbs
    request_type_ids = payload_requests.group(:request_type_id).count.keys

    request_type_ids.map { |id| RequestType.where(id: id).first.verb }
  end

  def top_three_referrers
    referrer_url_id_hash = payload_requests.group(:referrer_url_id).count

    sorted_arr = referrer_url_id_hash.sort_by { |k,v| v }.reverse

    addresses = sorted_arr.map do |elem|
      ReferrerUrl.where(id: elem[0]).first.url_address
    end

    addresses[0..2]
  end

  def top_three_user_systems
    # this method is not finished
    user_system_id_hash = payload_requests.group(:user_system_id).count

    sorted_arr = user_system_id_hash.sort_by { |k, v| v }.reverse

    systems = sorted_arr.map do |elem|
      UserSystem.where(id: elem[0]).first.browser
    end
  end
end
