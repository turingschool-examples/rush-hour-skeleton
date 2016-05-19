require_relative "../test_helper"

class EventNameTest < Minitest::Test
  include TestHelpers
  def test_validations_work
    event = EventName.create({
        event_name: "Lucy's BADDDDDD boys"
      })
    assert event.valid?
  end

  def test_empty_string_is_invalid
    event = EventName.create({
        event_name: ""
      })
    assert event.invalid?
  end

  def test_nil_is_invalid
    event = EventName.create({
        event_name: nil
      })
    assert event.invalid?
  end


  def test_no_info_is_invalid
    event = EventName.create
    assert event.invalid?
  end

  def test_it_has_relationship_with_payload_request
    name = EventName.new
    assert_respond_to(name, :payload_requests)
  end
end
