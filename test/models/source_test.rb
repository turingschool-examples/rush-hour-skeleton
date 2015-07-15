require './test/test_helper'

module TrafficSpy
  class SourceTest < Minitest::Test

    def test_source_returns_most_requested_urls
      populate
      source = Source.find_by(identifier: 'jumpstartlab')
      source.most_requested_urls
      expected = ["http://jumpstartlab.com/apply",
                 "http://jumpstartlab.com",
                 "http://jumpstartlab.com/blog"]
     assert_equal expected, source.most_requested_urls
    end

    def test_source_returns_browser_breakdown
      populate
      source = Source.find_by(identifier: 'jumpstartlab')
      source.browser_breakdown
      expected = ["Chrome", "Safari", "Firefox"]
      assert_equal expected, source.browser_breakdown
    end

    def test_source_returns_os_breakdown
      populate
      source = Source.find_by(identifier: 'jumpstartlab')
      source.browser_breakdown
      expected = ["Macintosh", "Windows", "Linux"]
      assert_equal expected, source.os_breakdown
    end

    private

    def populate
      register_application
      save_urls_to_table
      save_browsers_to_table
      save_os_to_table
      save_payloads_to_table
    end

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

    def save_os_to_table
      OperatingSystem.create(name: "Macintosh")
      OperatingSystem.create(name: "Windows")
      OperatingSystem.create(name: "Linux")
    end

    def save_payloads_to_table
      source = Source.find_by(identifier: "jumpstartlab")
      payload_sample.each do |datum|
        source.payloads.create(datum)
      end
    end

    def payload_sample
      [{"digest":"6", "url_id":find_url_id("http://jumpstartlab.com/apply"), "browser_id":find_browser_id("Chrome"), "operating_system_id":find_os_id("Macintosh")},
       {"digest":"3", "url_id":find_url_id("http://jumpstartlab.com"), "browser_id":find_browser_id("Chrome"), "operating_system_id":find_os_id("Windows")},
       {"digest":"4", "url_id":find_url_id("http://jumpstartlab.com/blog"), "browser_id":find_browser_id("Firefox"), "operating_system_id":find_os_id("Macintosh")},
       {"digest":"1", "url_id":find_url_id("http://jumpstartlab.com/apply"), "browser_id":find_browser_id("Safari"), "operating_system_id":find_os_id("Linux")},
       {"digest":"6", "url_id":find_url_id("http://jumpstartlab.com/apply"), "browser_id":find_browser_id("Safari"), "operating_system_id":find_os_id("Windows")},
       {"digest":"6", "url_id":find_url_id("http://jumpstartlab.com"), "browser_id":find_browser_id("Chrome"), "operating_system_id":find_os_id("Macintosh")}]
    end

    def find_url_id(url)
      Url.find_by(address: url).id
    end

    def find_browser_id(url)
      Browser.find_by(name: url).id
    end

    def find_os_id(url)
      OperatingSystem.find_by(name: url).id
    end

  end
end
