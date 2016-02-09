require_relative '../test_helper'

class EventNameTest < Minitest::Test
  def test_responds_to_payloads
    e = EventName.create(eventName: "social")

    assert e.respond_to? :payloads
  end

  def test_brings_in_correct_data
    e = EventName.create(eventName: "social")

    assert_equal "social", e.eventName
  end

  def test_wont_validate_incorrect_data
    e = EventName.create
    assert_nil e.id

    d = EventName.new eventName: nil
    assert_nil d.eventName
  end
end
