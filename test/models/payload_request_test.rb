require_relative '../test_helper.rb'

class PayloadRequestTest < Minitest::Test
  include TestHelpers, DataProcessor

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
    date_time = DateTime.new

    assert PayloadRequest.all.empty?
    payload_request = PayloadRequest.create(requested_at: date_time, responded_in: 30, url_id: 1, referred_by_id: 2, request_type_id: 3, u_agent_id: 4, resolution_id: 5, ip_id: 6)

    assert_equal 30, payload_request.responded_in
    assert payload_request.valid?
    refute PayloadRequest.all.empty?
  end

  def test_it_can_appropriately_process_data_for_columns
    request = '{
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
    payload_request = process_payload(request)
    assert_equal 37, payload_request.responded_in
  end

  def test_it_can_hold_attributes
    date_time = DateTime.new
    payload_request = PayloadRequest.create(requested_at: date_time, responded_in: 30, url_id: 1, referred_by_id: 2, request_type_id: 3, u_agent_id: 4, resolution_id: 5, ip_id: 6)

    assert_equal date_time, payload_request.requested_at
    assert_equal 30, payload_request.responded_in
    assert_equal 1, payload_request.url_id
    assert_equal 2, payload_request.referred_by_id
    assert_equal 3, payload_request.request_type_id
    assert_equal 4, payload_request.u_agent_id
    assert_equal 5, payload_request.resolution_id
    assert_equal 6, payload_request.ip_id
  end

end
