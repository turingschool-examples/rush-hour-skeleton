require_relative '../test_helper'

class RequestTest < Minitest::Test
  include TestHelpers

  def test_request_can_instantiate_with_verb
    r = Request.new(verb: "GET")
    assert r.valid?
  end

  def test_request_needs_verb_to_instantiate
    r = Request.new()
    refute r.valid?
  end

  def test_request_has_a_verb
    r = Request.create(verb: "GET")
    assert_equal "GET", r.verb
  end

  def test_request_has_payload_requests
    r = Request.new(verb: "GET")
    assert_respond_to r, :payload_requests
  end

end
