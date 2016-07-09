class Client < ActiveRecord::Base
  validates :root_url, presence: true
  validates :identifier, presence: true, uniqueness: true
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :urls, through: :payload_requests
  has_many :software_agents, through: :payload_requests
  has_many :resolutions, through: :payload_requests

  def average_response_time
    payload_requests.average(:responded_in).to_i
  end

  def max_response_time
    payload_requests.maximum(:responded_in).to_i
  end

  def min_response_time
    payload_requests.minimum(:responded_in).to_i
  end

  def most_frequent_request_type #test that most freq always come last in the hash
    top_req = request_types.group(:verb).count.sort_by {|ua| ua[-1]}
    top_req.last[0]
  end


  # def self.average_response_time(identifier)
  #   client = Client.where(identifier: identifier).take
  #   client.payload_requests.average(:responded_in).to_i
  # end
  #
  # def self.max_response_time(identifier)
  #   client = Client.where(identifier: identifier).take
  #   client.payload_requests.maximum(:responded_in).to_i
  # end
  #
  # def self.min_response_time(identifier)
  #   client = Client.where(identifier: identifier).take
  #   client.payload_requests.minimum(:responded_in).to_i
  # end
end
