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

    def self.min_response_time
      all.minimum("responded_in")
    end

    def self.most_requested_type
      request_counts = all.group(:request_type).count
      request_counts.max_by{ |key, value| value }[0]
    end

    def self.all_http_verbs_used
      all.map do |payload|
        payload.request_type
      end
    end

    def self.most_requested_urls
      url_counts = all.group(:url).count
      raw_urls = url_counts.sort_by { |key, value| value }.reverse
      raw_urls.map { |url_obj| url_obj[0] }
    end

    def self.all_u_agents
      all.map do |payload|
        payload.u_agent
      end
    end

    def self.all_screen_resolutions
      all.map do |payload|
        payload.resolution
      end
    end





end
