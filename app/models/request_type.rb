class RequestType < ActiveRecord::Base
  has_many :payloads
  validates :verb, presence: true

  def self.most_frequent_request
    RequestType.all.max_by do |verb|
      verb.payloads.count
    end.verb
  end

  def self.verbs_used
    RequestType.pluck(:verb)
  end

end
