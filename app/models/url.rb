require 'uri'

class Url < ActiveRecord::Base
  validates :address, presence: true
  has_many :payloads

  def relative_path(uri)
    URI(uri).path.split('/').last
  end

  def self.create_url(root_url, path)
    root_url + '/' + path
  end

  def self.longest_response(address)
    @address = address
    self.response_times(address).last
  end

  def self.shortest_response(address)
    self.response_times(address).first
  end

  def self.average_response(address)
    times = self.response_times(address)
    times.reduce(:+) / times.length
  end

  def self.http_verbs(address)
    url = Url.find_by(address: address)
    url.payloads.map { |payload| payload.request_type.http_verb}
  end


  def self.popular_referrer(address)
    url = Url.find_by(address: address)
    references = url.payloads.map { |payload| payload.reference.link }
    references.max
  end

  def self.popular_user_agent(address)
    url = Url.find_by(address: address)
    url.payloads.map { |payload| payload.payload_user_agent }
  end

  private

  def self.response_times(address)
    url = Url.find_by(address: address)
    times = url.payloads.map { |payload| payload.responded_in }
    times.sort
  end
end
