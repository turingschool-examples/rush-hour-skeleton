require_relative '../test_helper'

class EventNameTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert EventName
  end

  def test_can_create_event_id_through_payload_request
    pr = create_payload_1

    assert_equal "socialLogin", EventName.find(1).event_name
    assert_equal 1, pr.event_name_id
  end

  def test_can_create_event_names
    name = {event_name: "socialLogin"}
    en = EventName.create(name)

    assert_equal "socialLogin", en.event_name
    assert_equal 1, en.id
  end
end
