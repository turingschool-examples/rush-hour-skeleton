require_relative '../test_helper'

class ApplicationEventsTest < ControllerTest

  def create_source(identifier)
    post('/sources', {identifier: identifier, rootUrl: "http://#{identifier}.com" })
  end

  def create_payload_post(identifier)
    post("/sources/#{identifier}/data", { payload:
        { :url=>              "http://#{identifier}.com/blog",
          :requestedAt=>      "2013-02-16 21:38:28 -0700",
          :respondedIn=>      37,
          :referredBy=>       "http://#{identifier}.com",
          :requestType=>      "GET",
          :parameters=>       [],
          :eventName=>        "socialLogin",
          :userAgent=>        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
          :resolutionWidth=>  "1920",
          :resolutionHeight=> "1280",
          :ip=>               "63.29.38.211"
        }.to_json } )
  end

  def test_loads_events_for_registered_source
    create_source("jumpstartlab")
    get("/sources/jumpstartlab/events")
    
    assert_equal 200, last_response.status
  end
end
