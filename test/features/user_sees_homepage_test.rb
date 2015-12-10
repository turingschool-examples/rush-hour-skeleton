require_relative "../test_helper"

class UserSeesAnalyticsTest < FeatureTest
  def test_homepage_is_displayed
    #as an unregistered user
    #when I visit the homepage
    visit '/'
    #Then I see the homepage displayed
    assert page.has_content?("Traffic Spy")
  end
end
