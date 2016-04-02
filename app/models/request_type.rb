class RequestType < ActiveRecord::Base
  validates :verb, presence: true

  has_many :payload_requests

  def self.most_frequent
    group(:verb).order("count_all desc").count
  end

  def self.all_verbs_used
    pluck(:verb)
  end
end
