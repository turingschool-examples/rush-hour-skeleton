require_relative '../test_helper'

class EventTest < Minitest::Test

  include TestHelpers

  def test_it_returns_false_when_partial_information_is_entered
    event = Event.new({ })
    refute event.save
  end

  def test_it_returns_true_when_all_information_is_entered
    event = Event.new({ name: "events!"})
    assert event.save
  end

  def test_it_lists_events_most_received_to_least
    event1 = Event.create({ name: "events!"})
    event2 = Event.create({ name: "events!"})
    event3 = Event.create({ name: "A-list events!"})
    assert_equal ["events!", "A-list events!"], Event.list_events_by_frequency

  end
end
