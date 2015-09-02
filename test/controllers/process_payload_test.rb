require "./test/test_helper"

class ProcessPayloadTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def test_it_processes_a_correct_payload
    payload = { "url": "http://jumpstartlab.com/blog",
                "requestedAt": "2013-02-16 21:38:28 -0700",
                "respondedIn": 37,
                "referredBy": "http://jumpstartlab.com",
                "requestType": "GET",
                "parameters": [],
                "eventName": "socialLogin",
                "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2)
                              AppleWebKit/537.17 (KHTML, like Gecko)
                              Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth": "1920",
                "resolutionHeight": "1280",
                "ip": "63.29.38.211"
    }

    User.create(:identifier => "jumpstartlab", :root_url => "http://jumpstartlab.com")

    post "/sources/jumpstartlab/data", payload


    assert_equal 1, SubUrl.count
    assert_equal payload[:url], SubUrl.first.sub_url

    # assert_equal 1, Response.count
    # assert_equal payload["requestAt"], Response.first.requested_at
    # assert_equal payload["respondedIn"], Response.first.responded_in
    # assert_equal payload["ip"], Response.first.ip
    # assert_equal payload["parameters"], Response.first.parameters

    # assert_equal 1, Referrer.count
    # assert_equal 1, Resolution.count
    # assert_equal 1, Event.count
    # assert_equal 1, UserAgent.count

  end

  def teardown
    DatabaseCleaner.clean
  end
end
