class Url < ActiveRecord::Base
  validates :path, presence:true, uniqueness: true
  has_many :requests

  def longest_response_time
    requests.maximum(:response_time)
  end

  def shortest_response_time
    requests.minimum(:response_time)
  end

  def average_response_time
    requests.average(:response_time).to_i
  end

  def verbs
    requests.pluck(:verb).uniq
  end

  def popular_referrers
    requests.group(:referral).count.sort_by {|k,v|v}.reverse[0..2]
  end

  def popular_user_agents
    requests.group(:browser, :os).count.sort_by {|k,v|v}.reverse[0..2]
  end
end
