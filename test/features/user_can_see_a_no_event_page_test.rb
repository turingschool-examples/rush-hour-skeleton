require_relative '../test_helper'

class UserCanNoEventPage < FeatureTest
  include TestHelpers

  def test_user_see_a_no_event_page
    setup_client
    path = '/sources/jumpstartlab/events/needstarbucks'
    visit path

    assert_equal path, current_path

    assert page.has_content?("Event not found")
    assert page.has_content?("Events Index")
  end
end
