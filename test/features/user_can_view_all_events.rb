require_relative '../test_helper'

class UserCanViewAllEventsPage < FeatureTest
  include TestHelpers

  def test_user_see_all_events
    path = '/sources/jumpstartlab/events'
    visit path

    assert_equal path, current_path
    within("h2") do
      assert page.has_content?("Client not registered")
    end
  end


