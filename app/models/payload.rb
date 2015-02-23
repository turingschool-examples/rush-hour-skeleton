class Payload < ActiveRecord::Base
  validates :url_id, :requested_at, :responded_in, :reference_id,
            :request_type_id, :event_id, :payload_user_agent_id, :resolution_id, :ip_id,
            :digest, :source_id, presence: true

  belongs_to :source
  belongs_to :url
  belongs_to :reference
  belongs_to :request_type
  belongs_to :event
  belongs_to :payload_user_agent
  belongs_to :resolution
  belongs_to :ip

  def simplified_json
    { "payload" => payload }.to_json
  end

  def error_response
    errors.full_messages.join ", "
  end

  def self.ranked_urls_hash
    all.map { |payload| payload.url }.inject(Hash.new(0)) {|sum,url| sum[url.address]+=1; sum }.sort_by { |key, val| -val }.to_h
  end

  def self.relative_url_paths
    all.map { |payload| payload.url.relative_path(payload.url.address) }.uniq
  end

  def self.response_times
    all.map { |payload| payload.responded_in }
  end
end
