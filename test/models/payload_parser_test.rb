require './test/test_helper'

module TrafficSpy
  class PayloadParserTest < ControllerTest
    def test_it_returns_url_data_in_the_correct_format
      register_application
      post '/sources/jumpstartlab/data', payload
      assert_equal "http://jumpstartlab.com/blog", Url.first.address
    end 

    def test_it_returns_requested_at_data_in_the_correct_format
      register_application
      post '/sources/jumpstartlab/data', payload
      assert_equal "2013-02-16 21:38:28 -0700", Payload.first.requested_at
    end

    def test_it_returns_responded_in_data_in_the_correct_format
      register_application
      post '/sources/jumpstartlab/data', payload
      assert_equal 37, Payload.first.responded_in
    end

    def test_it_returns_referred_by_data_in_the_correct_format
      register_application
      post '/sources/jumpstartlab/data', payload
      assert_equal "http://jumpstartlab.com", Payload.first.referred_by
    end

    def test_it_returns_request_type_data_in_the_correct_format
      register_application
      post '/sources/jumpstartlab/data', payload
      assert_equal "GET", Payload.first.request_type
    end

    def test_it_returns_event_name_data_in_the_correct_format
      register_application
      post '/sources/jumpstartlab/data', payload
      assert_equal "socialLogin", Event.first.name
      assert_equal "socialLogin", Payload.first.event.name
    end

    def test_it_returns_OS_data_in_the_correct_format
      register_application
      post '/sources/jumpstartlab/data', payload
      assert_equal "macintosh", OperatingSystem.first.name
    end

    def test_it_returns_browser_data_in_the_correct_format
      register_application
      post '/sources/jumpstartlab/data', payload
      assert_equal "chrome", Browser.first.name
    end

    def test_it_returns_resolution_in_the_correct_format
      register_application
      post '/sources/jumpstartlab/data', payload
      assert_equal "1920", ScreenResolution.first.width
      assert_equal "1280", ScreenResolution.first.height
    end

    private

    def register_application
      Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    end

    def payload
      { payload: '{
        "url":"http://jumpstartlab.com/blog",
        "requestedAt":"2013-02-16 21:38:28 -0700",
        "respondedIn":37,
        "referredBy":"http://jumpstartlab.com",
        "requestType":"GET",
        "parameters":[],
        "eventName": "socialLogin",
        "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth":"1920",
        "resolutionHeight":"1280",
        "ip":"63.29.38.211"
      }' }
    end
  end
end
