require './test/test_helper'

module TrafficSpy
  class SourceTest < Minitest::Test

    def test_source_returns_most_requested_urls
      register_application
      save_urls_to_table
      save_payloads_to_table
      source = Source.find_by(identifier: 'jumpstartlab')
      source.most_requested_urls


    end

    private

    def register_application
      Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    end

    def save_urls_to_table
      Url.create(address: "http://jumpstartlab.com/blog")
      Url.create(address: "http://jumpstartlab.com")
      Url.create(address: "http://jumpstartlab.com/apply")
    end

    def save_payloads_to_table
      source = Source.find_by(identifier: "jumpstartlab")
      payload_sample.each do |datum|
        source.payloads.create(datum)
      end
    end

    def payload_sample
      [{"digest":"6", "url_id":find_url_id("http://jumpstartlab.com/apply")},
       {"digest":"3", "url_id":find_url_id("http://jumpstartlab.com")},
       {"digest":"4", "url_id":find_url_id("http://jumpstartlab.com/blog")},
       {"digest":"1", "url_id":find_url_id("http://jumpstartlab.com/apply")},
       {"digest":"6", "url_id":find_url_id("http://jumpstartlab.com/apply")},
       {"digest":"6", "url_id":find_url_id("http://jumpstartlab.com")}]
    end

    def find_url_id(url)
      Url.find_by(address: url).id
    end

  end
end


