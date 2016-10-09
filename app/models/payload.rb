class Payload < ActiveRecord::Base

  belongs_to :request_type
  belongs_to :url
  belongs_to :referred_by
  belongs_to :event_name
  belongs_to :agent
  belongs_to :resolution
  belongs_to :ip

  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :referred_by_id, presence: true
  validates :request_type_id, presence: true
  validates :event_name_id, presence: true
  validates :agent_id, presence: true
  validates :resolution_id, presence: true
  validates :ip_id, presence: true

  def self.average_response_time
    Payload.average(:responded_in)
  end

  def self.max_response_time
    Payload.maximum(:responded_in)
  end

  def self.min_response_time
    Payload.minimum(:responded_in)
  end

  def self.most_frequent(column)
    column_values = Payload.pluck("#{column.to_s}_id".to_sym)
    id_occurance = column_values.reduce({}) do |r, id|
      r[id] = column_values.count(id)
      r
    end
    #TODO MAKE DYNAMIC
    RequestType.find(id_occurance.max_by { |k, v| v }[0]).send(column)
  end

  def self.all_http_verbs
    Payload.pluck(:request_type_id).uniq.reduce([]) do |r, id|
      r << RequestType.find(id).request_type
      r
    end
  end

  def self.most_to_least_requested
    order = Payload.order('url_id DESC')
    order.reduce([]) do |r, obj|
      r << obj.url.url
      r
    end.uniq
  end

end
