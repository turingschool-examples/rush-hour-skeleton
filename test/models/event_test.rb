require_relative '../test_helper'

class EventTest < Minitest::Test
  include TestHelper

  def test_it_can_save_an_event
    Event.create(name: "socialLogin")

    event = Event.first

    assert_equal "socialLogin", event.name
  end

  def test_it_wont_save_an_invalid_event
    Event.create

    assert_equal [], Event.all.to_a
  end

end
