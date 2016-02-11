require 'pry'
class RequestType < ActiveRecord::Base
  has_many :payloads
  validates :verb, presence: true

  def self.find_distinct_verbs
    self.distinct(:verb)
  end

  def self.most_frequent_request_type
    self.group(:verb).order("count_verb desc").count("verb").first[0]
  end

  def self.returns_list_verbs
    self.pluck(:verb).uniq.join(", ") #return to refactor into db call
  end
end
