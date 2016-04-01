require_relative '../test_helper'

class UserCanViewDataForTheirApp < FeatureTest
  include TestHelpers

  def test_viewer_can_visit_dashboard_path
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    path = '/sources/jumpstartlab'
    visit path

    assert_equal path, current_path
    within("#identifier") do
      assert page.has_content?("Jumpstartlab")
    end

    within('#analytics') do
      assert page.has_content?("Max Response time")
      assert page.has_content?("Min Response time")
      assert page.has_content?("A list of response times across all requests listed from longest response time to shortest response time")
      assert page.has_content?("Average Response time for this URL")
      assert page.has_content?("HTTP Verb(s) associated used")
      assert page.has_content?("Three most popular referrers")
      assert page.has_content?("Three most popular user agents")
    end
  end
end
