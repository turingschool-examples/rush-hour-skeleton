class Response < ActiveRecord::Base
  has_many :payloads
  has_many :urls, through: :payloads
  has_one :source, through: :payloads

  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :ip, presence: true

  def average_response_time(source)
    source.urls.map do |url|
      url.responses
    end.flatten
  end
end
