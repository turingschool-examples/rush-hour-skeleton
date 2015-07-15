require './test/test_helper'

module TrafficSpy
  class SourceTest < Minitest::Test

    def test_source_returns_most_requested_urls
      register_application
      save_urls_to_table
      save_browsers_to_table
      save_payloads_to_table
      source = Source.find_by(identifier: 'jumpstartlab')
      source.most_requested_urls
      expected = ["http://jumpstartlab.com/apply",
                 "http://jumpstartlab.com",
                 "http://jumpstartlab.com/blog"]
     assert_equal expected, source.most_requested_urls
    end

    def test_source_returns_browser_breakdown
      register_application
      save_urls_to_table
      save_browsers_to_table
      save_payloads_to_table
      source = Source.find_by(identifier: 'jumpstartlab')
      source.browser_breakdown
      expected = ["Chrome", "Safari", "Firefox"]
      assert_equal expected, source.browser_breakdown
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

    def save_browsers_to_table
      Browser.create(name: "Chrome")
      Browser.create(name: "Firefox")
      Browser.create(name: "Safari")
    end

    def save_payloads_to_table
      source = Source.find_by(identifier: "jumpstartlab")
      payload_sample.each do |datum|
        source.payloads.create(datum)
      end
    end

    def payload_sample
      [{"digest":"6", "url_id":find_url_id("http://jumpstartlab.com/apply"), "browser_id":find_browser_id("Chrome")},
       {"digest":"3", "url_id":find_url_id("http://jumpstartlab.com"), "browser_id":find_browser_id("Chrome")},
       {"digest":"4", "url_id":find_url_id("http://jumpstartlab.com/blog"), "browser_id":find_browser_id("Firefox")},
       {"digest":"1", "url_id":find_url_id("http://jumpstartlab.com/apply"), "browser_id":find_browser_id("Safari")},
       {"digest":"6", "url_id":find_url_id("http://jumpstartlab.com/apply"), "browser_id":find_browser_id("Safari")},
       {"digest":"6", "url_id":find_url_id("http://jumpstartlab.com"), "browser_id":find_browser_id("Chrome")}]
    end

    def find_url_id(url)
      Url.find_by(address: url).id
    end

    def find_browser_id(url)
      Browser.find_by(name: url).id
    end

  end
end
