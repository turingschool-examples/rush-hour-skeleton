require './test/test_helper'

class PayloadCreatorTest < Minitest::Test
  def test_can_create_a_payload
    payload = TrafficSpy::Payload
    create_payloads(1)

    assert_equal 1, payload.all.count
  end

  def test_can_create_two_payloads
    payload = TrafficSpy::Payload
    create_payloads(2)

    assert_equal 2, payload.all.count
  end

  def test_can_create_twelve_payloads
    payload = TrafficSpy::Payload
    create_payloads(12)

    assert_equal 12, payload.all.count
  end
end
