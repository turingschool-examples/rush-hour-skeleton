require 'time'

class Payload < ActiveRecord::Base

  belongs_to :request_type
  belongs_to :url
  belongs_to :referred_by
  belongs_to :event_name
  belongs_to :agent
  belongs_to :resolution
  belongs_to :ip
  belongs_to :client

  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referred_by_id, presence: true
  validates :request_type_id, presence: true
  validates :event_name_id, presence: true
  validates :agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true
  validates_uniqueness_of :client_id, scope: [:url_id, :requested_at, :responded_in, :referred_by_id, :request_type_id, :event_name_id, :agent_id, :resolution_id, :ip_id]

  def self.average_response_time
    Payload.average(:responded_in).round(1)
  end

  def self.max_response_time
    Payload.maximum(:responded_in)
  end

  def self.min_response_time
    Payload.minimum(:responded_in)
  end

  def self.most_frequent_request_type
    column_values = Payload.pluck(:request_type_id)
    id_occurrence = column_values.reduce({}) do |result, id|
      result[id] = column_values.count(id)
      result
    end
    RequestType.find(id_occurrence.max_by { |k, v| v }[0]).request_type
  end

  def hour
    Time.at(requested_at.to_i).hour
  end
end
