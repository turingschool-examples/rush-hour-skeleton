require './test/test_helper'

module TrafficSpy
  class SourceTest < Minitest::Test

    def test_source_returns_most_requested_urls
      populate
      source = Source.find_by(identifier: 'jumpstartlab')
      expected = ["http://jumpstartlab.com/apply",
                 "http://jumpstartlab.com",
                 "http://jumpstartlab.com/blog"]
     assert_equal expected, source.most_requested_urls
    end

    def test_source_returns_browser_breakdown
      populate
      source = Source.find_by(identifier: 'jumpstartlab')
      expected = ["Chrome", "Safari", "Firefox"]
      assert_equal expected, source.browser_breakdown
    end

    def test_source_returns_os_breakdown
      populate
      source = Source.find_by(identifier: 'jumpstartlab')
      expected = ["Macintosh", "Windows", "Linux"]
      assert_equal expected, source.os_breakdown
    end

    def test_source_returns_screen_resolution_breakdown
      populate
      source = Source.find_by(identifier: 'jumpstartlab')
      expected = [["1280", "720"], ["800", "720"], ["900", "540"]]
      assert_equal expected, source.screen_resolution_breakdown
    end

    def test_source_returns_avg_response_times_per_url_by_longest_to_shortest
      populate
      source = Source.find_by(identifier: 'jumpstartlab')
      source.avg_response_times_per_url
      expected = {"http://jumpstartlab.com/apply": 6,
                  "http://jumpstartlab.com/blog": 7,
                  "http://jumpstartlab.com": 8}
      assert_equal expected, source.sorted_avg_response_times
    end

    private

    def populate
      register_application
      save_urls_to_table
      save_browsers_to_table
      save_os_to_table
      save_screen_resolutions_to_table
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

    def save_screen_resolutions_to_table
      ScreenResolution.create(width: "800", height: "720")
      ScreenResolution.create(width: "1280", height: "720")
      ScreenResolution.create(width: "900", height: "540")
    end

    def save_payloads_to_table
      source = Source.find_by(identifier: "jumpstartlab")
      payload_sample.each do |datum|
        source.payloads.create(datum)
      end
    end

    def payload_sample
      [{"digest":"6", "url_id":find_url_id("http://jumpstartlab.com/apply"),
        "browser_id":find_browser_id("Chrome"), "operating_system_id":find_os_id("Macintosh"),
        "screen_resolution_id":find_screen_resolution_id("1280", "720"),
       "response_time":6},
       {"digest":"3", "url_id":find_url_id("http://jumpstartlab.com"),
         "browser_id":find_browser_id("Chrome"), "operating_system_id":find_os_id("Windows"),
         "screen_resolution_id":find_screen_resolution_id("800", "720"),
        "response_time":8},
       {"digest":"4", "url_id":find_url_id("http://jumpstartlab.com/blog"),
         "browser_id":find_browser_id("Firefox"), "operating_system_id":find_os_id("Macintosh"),
         "screen_resolution_id":find_screen_resolution_id("1280", "720"),
       "response_time":7},
       {"digest":"1", "url_id":find_url_id("http://jumpstartlab.com/apply"),
         "browser_id":find_browser_id("Safari"), "operating_system_id":find_os_id("Linux"),
         "screen_resolution_id":find_screen_resolution_id("800", "720"),
        "response_time":6},
       {"digest":"6", "url_id":find_url_id("http://jumpstartlab.com/apply"),
         "browser_id":find_browser_id("Safari"), "operating_system_id":find_os_id("Windows"),
         "screen_resolution_id":find_screen_resolution_id("1280", "720"),
        "response_time":6},
       {"digest":"6", "url_id":find_url_id("http://jumpstartlab.com"),
         "browser_id":find_browser_id("Chrome"), "operating_system_id":find_os_id("Macintosh"),
         "screen_resolution_id":find_screen_resolution_id("900", "540"),
        "response_time":8}]
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

    def find_screen_resolution_id(width, height)
      ScreenResolution.find_by_width_and_height(width, height).id
    end



  end
end
