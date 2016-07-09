class RequestType < ActiveRecord::Base
  validates :verb, presence: true, uniqueness: true
  has_many :payload_requests
  # list all verbs used in addition to calculating the most common
  def self.frequent_request_types
    RequestType.group(:verb).order('count_id DESC').limit(1).count(:id).first.first
    # pluck(:verb).all.max_by do |verb|
    #   verb.count
    # end
    # self.group(:verb)
    # count(:verb)
  end

  def self.verb_list
    verbs = RequestType.distinct.pluck(:verb).join(' , ')
    # pluck(:verb)
    end
  end


# r = RequestType.where(verb: 'get')
#
# r.payload_requests
