require_relative '../test_helper'

module TrafficSpy
  class UrlTest < ControllerTest

    def test_it_can_grab_longest_response_time
      populate
      url = Url.last
      assert_equal 23, url.longest_response_time
    end

    def test_it_can_grab_shortest_response_time
      populate
      url = Url.last
      assert_equal 17, url.shortest_response_time
    end

    def test_it_can_grab_average_response_time
      populate
      url = Url.last
      assert_equal 19.666666666666668, url.average_response_time
    end

    def test_it_can_return_HTTP_verbs
      populate
      url = Url.last
      assert_equal ["GET", "POST"], url.request_type
    end

    def test_it_can_list_most_popular_referrers
      populate
      url = Url.last
      assert_equal({"www.google.com"=>2, "www.nytimes.com"=>1}, url.most_popular_referrers)
    end

    def test_it_can_list_most_popular_user_agent_browsers
      populate
      url = Url.last
      assert_equal({:Chrome=>1, :Safari=>2}, url.most_popular_user_agent_browsers)
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
        "response_time":6, "responded_in":23, "request_type": "GET", "referred_by": "www.google.com"},
       {"digest":"3", "url_id":find_url_id("http://jumpstartlab.com"),
        "browser_id":find_browser_id("Chrome"), "operating_system_id":find_os_id("Windows"),
        "screen_resolution_id":find_screen_resolution_id("800", "720"),
        "response_time":8, "responded_in":4, "request_type": "POST", "referred_by": "www.facebook.com"},
       {"digest":"4", "url_id":find_url_id("http://jumpstartlab.com/blog"),
        "browser_id":find_browser_id("Firefox"), "operating_system_id":find_os_id("Macintosh"),
        "screen_resolution_id":find_screen_resolution_id("1280", "720"),
        "response_time":7, "responded_in":8, "request_type": "GET", "referred_by": "www.wsj.com"},
       {"digest":"1", "url_id":find_url_id("http://jumpstartlab.com/apply"),
        "browser_id":find_browser_id("Safari"), "operating_system_id":find_os_id("Linux"),
        "screen_resolution_id":find_screen_resolution_id("800", "720"),
        "response_time":6, "responded_in":19, "request_type": "POST", "referred_by": "www.google.com"},
       {"digest":"6", "url_id":find_url_id("http://jumpstartlab.com/apply"),
        "browser_id":find_browser_id("Safari"), "operating_system_id":find_os_id("Windows"),
        "screen_resolution_id":find_screen_resolution_id("1280", "720"),
        "response_time":6, "responded_in":17, "request_type": "POST", "referred_by": "www.nytimes.com"},
       {"digest":"6", "url_id":find_url_id("http://jumpstartlab.com"),
        "browser_id":find_browser_id("Chrome"), "operating_system_id":find_os_id("Macintosh"),
        "screen_resolution_id":find_screen_resolution_id("900", "540"),
        "response_time":8, "responded_in":15, "request_type": "GET", "referred_by": "www.watmm.com"}]
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