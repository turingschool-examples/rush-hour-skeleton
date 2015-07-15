require_relative '../test_helper'


class SourceTest < Minitest::Test

  def test_source_returns_most_requested_urls
    register_application
    save_urls_to_table
    save_payloads_to_table
    source = TrafficSpy::Source.find_by(identifier: 'jumpstartlab')
    source.most_requested_urls


  end

  private

  def register_application
    TrafficSpy::Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
  end

  def save_urls_to_table
    TrafficSpy::Url.create(address: "http://jumpstartlab.com/blog")
    TrafficSpy::Url.create(address: "http://jumpstartlab.com")
    TrafficSpy::Url.create(address: "http://jumpstartlab.com/apply")
  end

  def save_payloads_to_table
    source = TrafficSpy::Source.find_by(identifier: "jumpstartlab")
    payload_sample.each do |datum|
      source.payloads.create(datum)
    end
  end

  def payload_sample
    [{"digest":"3", "url_id":find_url_id("http://jumpstartlab.com")},
    {"digest":"4", "url_id":find_url_id("http://jumpstartlab.com/blog")},
    {"digest":"1", "url_id":find_url_id("http://jumpstartlab.com/apply")}]
  end

  def find_url_id(url)
    TrafficSpy::URL.find_by(url: url)
  end

end