require_relative '../test_helper'

class EventTest < Minitest::Test
  def test_responds_to_payloads
    e = Event.create(name: "social")

    assert e.respond_to? :payloads
  end

  def test_brings_in_correct_data
    e = Event.create(name: "social")

    assert_equal "social", e.name
  end

  def test_wont_validate_incorrect_data
    e = Event.create
    assert_nil e.id

    d = Event.new name: nil
    assert_nil d.name
  end
end
