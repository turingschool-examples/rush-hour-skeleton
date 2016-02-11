require_relative '../test_helper'

class EventTest < Minitest::Test
  include TestHelpers

  def test_request_can_instantiate_with_name
    e = Event.new(name: "socialLogin")
    assert e.valid?
  end

  def test_request_needs_name_to_instantiate
    e = Event.new()
    refute e.valid?
  end

  def test_request_has_a_name
    e = Event.create(name: "socialLogin")
    assert_equal "socialLogin", e.name
  end

  def test_request_has_payload_requests
    e = Event.new(name: "socialLogin")
    assert_respond_to e, :payload_requests
  end

end
