class Url < ActiveRecord::Base
  validates :address, :referral_id,
            presence: true

  belongs_to :referral
  has_many :payload_requests
  has_many :request_types, through: :payload_requests

  def all_response_times
    payload_requests.pluck(:responded_in).sort.reverse
  end

  def average_response_time
    (all_response_times).sum / (Url.count)
  end

  def all_verbs
    request_types.pluck(:verb)
  end

  def self.most_popular_referrers
    referers = Url.all.pluck(:referral_id)
    freq = referers.reduce(Hash.new(0)) { |hash,value| hash[value] += 1; hash }

    # id = freq.max_by { |key,value| value}
    # require "pry"; binding.pry
    # id = id.first
    # Referral.find(id).address
  end

  def self.sample
    a = most_popular_referrers
    b = a.sort_by {|_key, value| value}
    # require "pry"; binding.pry
  end

  def self.fetch_pairs
    c = sample
    d = c[-3..-1]
  end

  def self.extract_ids
    e = fetch_pairs
    f = e.map do |elem|
      elem[0]
    end
    f
  end

  def match_id_with_referral_address
    g = extract_ids
    g.each do |ref|
      ref
    end
  end


  # def most_popular_referrers
  #     require "pry"; binding.pry
  #   referrals.pluck(:address)
  # end

end
