require './test/test_helper'

class UserSeesAnalyticsTest < FeatureTest
  def test_homepage_is_displayed
    visit '/'
    assert page.has_content?("Traffic Spy")
  end
end
