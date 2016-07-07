require_relative '../test_helper.rb'

class PayloadRequestTest < Minitest::Test
  include TestHelpers

  def test_it_parses_the_payload
    payload_request = JSON.parse('{
              "url": "http://jumpstartlab.com/blog",
              "requestedAt": "2013-02-16 21:38:28 -0700",
              "respondedIn": 37,
              "referredBy": "http://jumpstartlab.com",
              "requestType": "GET",
              "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
              "resolutionWidth": "1920",
              "resolutionHeight": "1280",
              "ip": "63.29.38.211"
            }')

    assert_equal "63.29.38.211", payload_request["ip"]
    assert_equal 37, payload_request["respondedIn"]
  end

  def test_database_starts_clean
    assert PayloadRequest.all.empty?
    payload_request = PayloadRequest.create(url: "http://jumpstartlab.com/blog",
                          requested_at: Date.today,
                          responded_in: 2,
                          referred_by: " 2",
                          request_type: " 2",
                          user_agent: "2 ",
                          resolution_width: "1290",
                          resolution_height: "800",
                          ip: "23.1.1.1")
    assert_equal 2, payload_request.responded_in
    assert payload_request.valid?
    refute PayloadRequest.all.empty?
  end

end
