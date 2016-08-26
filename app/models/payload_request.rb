require_relative 'data_parser'

class PayloadRequest < ActiveRecord::Base
  include DataParser

    belongs_to :url
    belongs_to :referred_by
    belongs_to :request_type
    belongs_to :u_agent
    belongs_to :resolution
    belongs_to :ip
    belongs_to :client

    validates :url_id, presence: true
    validates :requested_at, presence: true
    validates :responded_in, presence: true
    validates :referred_by_id, presence: true
    validates :request_type_id, presence: true
    validates :u_agent_id, presence: true
    validates :resolution_id, presence: true
    validates :ip_id, presence: true

    def self.average_response_time
      all.average("responded_in")
    end

    def self.max_response_time
      all.maximum("responded_in")
    end



end
