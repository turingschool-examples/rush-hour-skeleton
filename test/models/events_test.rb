require_relative '../test_helper'

class EventsTest < Minitest::Test

    def test_events_has_many_payloads
      event = Event.new
      assert_equal [], event.payloads
    end

end
