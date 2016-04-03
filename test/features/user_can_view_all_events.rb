require_relative '../test_helper'

class UserCanViewAllEventsPage < FeatureTest
  include TestHelpers

  def test_user_see_all_events
    setup_client
    referred_data
    path = '/sources/jumpstartlab'
    visit path

    assert_equal path, current_path

    within("h2") do
      assert page.has_content?("Your Events")
      assert page.has_content?("facebook")
      assert page.has_content?("socialLogin")
      assert page.has_content?("twitter")
    end
  end


