require_relative '../test_helper'

class PayloadHandlerTest < Minitest::Test

  def setup
    Client.create({"name" => "jumpstartlabs", "root_url" => "http://jumpstartlab.com"})
  end

  def payload
    {"payload"=>
    "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
   "splat"=>[],
   "captures"=>["jumpstartlab"],
   "identifier"=>"jumpstartlabs"}
  end

  def unregistered_user_payload
    {"payload"=>
    "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
   "splat"=>[],
   "captures"=>["jumpstartlab"],
   "identifier"=>"binglol"}
  end

  def missing_payload
    {"payload"=> nil,
    "splat"=>[],
    "captures"=>["jumpstartlab"],
    "identifier"=>"binglol"}
  end

  def test_payload_handler_can_parse_valid_payload_data
    ph = PayloadHandler.new(payload)

    assert_equal 200, ph.status
  end

  def test_payload_handler_returns_400_with_missing_payload
    ph = PayloadHandler.new(missing_payload)

    assert_equal 400, ph.status
    assert_equal "Payload Missing.", ph.body
  end

  def test_payload_handler_returns_403_with_duplicate_payload
    ph_1 = PayloadHandler.new(payload)
    assert_equal 200, ph_1.status

    ph_2 = PayloadHandler.new(payload)
    assert_equal 403, ph_2.status
    assert_equal "Duplicate Payload.", ph_2.body
  end

  def test_payload_handler_returns_403_with_unregistered_user
    ph = PayloadHandler.new(unregistered_user_payload)

    assert_equal 403, ph.status
    assert_equal "Application Not Registered.", ph.body
  end

  def test_payload_handler_can_create_all_necessary_database_entries_with_valid_payload
    ph = PayloadHandler.new(payload)

    assert_equal "http://jumpstartlab.com/blog", Payload.where(id: 1).pluck("path").first
    refute_equal "www.google.com", Payload.where(id: 1).pluck("referred_by").first
    assert_equal "socialLogin", Payload.where(id: 1).pluck("event_name").first
    assert_equal 1920, Payload.where(id: 1).pluck("resolution_width").first
    refute_equal 2, Payload.where(id: 1).pluck("resolution_height").first
  end
end
