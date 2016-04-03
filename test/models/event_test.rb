require_relative '../test_helper'

class EventTest < Minitest::Test
  include TestHelpers

  def test_it_can_accept_event
    event = Event.create(name: "socialLogin")

    assert_equal "socialLogin", event.name
  end

  def test_it_checks_for_empty_name
    event = Event.create(name: nil)

    assert_nil event.name
  end

  def test_it_responds_with_an_error_message
    event = Event.create(name: nil)

    assert_equal "can't be blank", event.errors.messages[:name][0]
  end
end
