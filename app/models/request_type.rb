class RequestType < ActiveRecord::Base
  has_many :payload_requests

  validates :name, presence: true

  def self.most_frequent_request_type
    verbs = RequestType.pluck(:name)
    verb_count = verbs.each_with_object(Hash.new(0)) { |verb, hash| hash[verb] += 1 }
    verb_count.max_by { |verb, count| count }.first
  end

  def self.all_request_types
    RequestType.pluck(:name).uniq
  end
end
