require_relative '../test_helper'

class EventNameTest < Minitest::Test
  include TestHelpers

  def test_class_exists
    assert EventName
  end

  def test_can_create_event_through_payload_request
    pr = create_payload_1

    assert_equal "socialLogin", EventName.find(1).event_name
    assert_equal 1, pr.event_name_id
  end

  def test_can_create_event_names
    name = {event_name: "socialLogin"}
    en = EventName.create(name)

    assert en.valid?
    assert_equal "socialLogin", en.event_name
    assert_equal 1, en.id
  end

  def test_the_same_event_name_will_not_be_added_to_database
    name = {event_name: "socialLogin"}
    en = EventName.create(name)

    assert_equal 1, EventName.all.count

    name2 = {event_name: "socialLogin"}
    en2 = EventName.create(name2)

    refute en2.valid?
    assert en2.id.nil?
    assert_equal 1, EventName.all.count
  end

  def test_can_create_list_of_events
    create_event_specific_payloads

    assert_equal ["signOut","socialLogin"],  EventName.event_list
  end

  def test_can_create_hourly_list
    create_event_specific_payloads
    client = Client.find(1)
    event = EventName.find(1)
    assert_equal [6, 10], EventName.hourly_list(client, event)
  end

  def test_count_total_occurrences_for_specific_event_type
    create_event_specific_payloads
    client = Client.find(1)
    event = EventName.find(1)
    assert_equal 2, EventName.event_total(client, event)
  end
end
