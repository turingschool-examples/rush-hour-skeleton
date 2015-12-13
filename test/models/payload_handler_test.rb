require_relative '../test_helper'

class PayloadHandlerTest < Minitest::Test

  def setup
    Client.create({"name" => "jumpstartlab", "root_url" => "http://jumpstartlab.com"})
  end

  def test_payload_handler_can_parse_valid_payload_data
    ph = PayloadHandler.new(payload)

    assert_equal 200, ph.status
  end

  def test_payload_handler_returns_400_with_nil_payload
    ph = PayloadHandler.new(nil_payload)

    assert_equal 400, ph.status
    assert_equal "Payload Missing.", ph.body
  end

  def test_payload_handler_returns_400_with_empty_payload
    ph = PayloadHandler.new(empty_payload)

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
    ph = PayloadHandler.new(unregistered_payload)

    assert_equal 403, ph.status
    assert_equal "Application Not Registered.", ph.body
  end

  def test_payload_handler_can_create_database_entries_with_valid_payload
    ph = PayloadHandler.new(payload)

    assert_equal "http://jumpstartlab.com/blog", Payload.where(id: 1).pluck("path").first
    assert_equal "socialLogin", Payload.where(id: 1).pluck("event_name").first
    assert_equal 1920, Payload.where(id: 1).pluck("resolution_width").first
    refute_equal "www.google.com", Payload.where(id: 1).pluck("referred_by").first
    refute_equal 2, Payload.where(id: 1).pluck("resolution_height").first
  end
end
