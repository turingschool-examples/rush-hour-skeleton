require_relative '../test_helper'

class UserCanViewAllEventsPage < FeatureTest
  include TestHelpers

  def test_user_see_all_events_for_the_account
    setup_client
    referrer_data
    path = "/sources/jumpstartlab/events"

    visit path

    assert_equal path, current_path
    assert page.has_content?("Your Events")
    assert page.has_content?("facebook")
    assert page.has_content?("socialLogin")
    assert page.has_content?("twitter")
  end
end


