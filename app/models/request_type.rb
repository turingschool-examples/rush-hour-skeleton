class RequestType < ActiveRecord::Base
  validates :verb, presence: true

  def self.most_frequent
    verb_hash = self.group(:verb).count
    verb_hash.max_by { |key, value| value }.first
  end

  def self.all_verbs_used
    self.distinct.pluck(:verb)
  end
end
