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
    Url.find_by(address: address).payloads.maximum(:responded_in)
  end

  def self.shortest_response(address)
    Url.find_by(address: address).payloads.minimum(:responded_in)
  end

  def self.average_response(address)
    Url.find_by(address: address).payloads.average(:responded_in).to_i
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
    browsers = url.payloads.map { |payload| payload.payload_user_agent.browser }
    oss = url.payloads.map { |payload| payload.payload_user_agent.os }
    [browsers.max, oss.max]
  end

end
