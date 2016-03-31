class PayloadRequest < ActiveRecord::Base
  belongs_to :url
  belongs_to :request_type
  belongs_to :referral
  belongs_to :user_agent
  belongs_to :client

  validates :url_id,           presence: true
  validates :requested_at,     presence: true
  validates :response_time,    presence: true
  validates :referral_id,      presence: true
  validates :request_type_id,  presence: true
  validates :event_id,         presence: true
  validates :user_agent_id,    presence: true
  validates :resolution_id,    presence: true
  validates :ip_id,            presence: true
  validates :client_id,        presence: true

  # def self.url_with_max_response_time
  #   # all.sort_by  { |payload| payload.response_time }.last.url.full_path
  #   order(response_time: :desc).first.url.full_path
  # end
  #
  # def self.url_with_min_response_time
  #   # all.sort_by { |payload| payload.response_time }.first.url.full_path
  #   order(response_time: :asc).first.url.full_path
  # end

  def self.average_response_time
    average("response_time")
    # average(:response_time)
  end

  def self.max_response_time
    maximum("response_time")
  end

  def self.min_response_time
    minimum("response_time")
  end
end
