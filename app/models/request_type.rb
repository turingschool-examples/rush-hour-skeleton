require 'pry'
class RequestType < ActiveRecord::Base
  has_many :payloads

  validates :verb, presence: true

  def self.list_distinct_verbs
    a = self.distinct(:verb).pluck(:verb)
  end

  def self.most_frequent_request_type
    self.group(:verb).order("count_verb desc").count("verb").first[0]
  end
end
