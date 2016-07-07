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

  def test_it_can_appropriately_label_data_for_columns
    raw_data = '{
              "url": "http://jumpstartlab.com/blog",
              "requestedAt": "2013-02-16 21:38:28 -0700",
              "respondedIn": 37,
              "referredBy": "http://jumpstartlab.com",
              "requestType": "GET",
              "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
              "resolutionWidth": "1920",
              "resolutionHeight": "1280",
              "ip": "63.29.38.211"
            }'
    data = parse_it(raw_data)
    formatted = assign_data(data)
    payload_request = PayloadRequest.create(formatted)
    assert_equal 37, payload_request.responded_in
  end

  def test_it_can_hold_attributes
    payload_request = PayloadRequest.create(requested_at: 2013-02-16 21:38:28 -0700, responded_in: 30, url_id: 1, referred_by_id: 2, request_type_id: 3, u_agent_id: 4, resolution_id: 5, ip_id: 6)
    assert_equal '/', referred_by.path
    assert_equal 'http://www.google.com', referred_by.root_url
    assert referred_by.valid?
  end
end
