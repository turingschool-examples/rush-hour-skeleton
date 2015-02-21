class Url < ActiveRecord::Base
  validates :address, presence: true
  has_many :payloads

  def self.create_url(identifier, path)
    identifier + '/urls' + '/' + path
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
    verbs = url.payloads.map { |payload| payload.request_type.http_verb}
  end

  private

  def self.response_times(address)
    url = Url.find_by(address: address)
    times = url.payloads.map { |payload| payload.responded_in }
    times.sort
  end


end
