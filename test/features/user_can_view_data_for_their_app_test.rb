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

  def test_user_gets_error_page_when_client_not_found
    path = '/sources/jumpstartlab'
    visit path

    assert_equal path, current_path
    within("h1") do
      assert page.has_content?("Error")
    end

  end

  def test_viewer_can_visit_dashboard_and_view_stats
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    path = '/sources/jumpstartlab'
    visit path

    setup_data

    assert_equal path, current_path
    within("#identifier") do
      assert page.has_content?("Jumpstartlab")
    end

    within('#analytics') do
      assert page.has_content?("Max Response time: 40")
      # assert page.has_content?("Min Response time: 20")
      # assert page.has_content?("A list of response times across all requests listed from longest response time to shortest response time")
      # assert page.has_content?("Average Response time for this URL")
      # assert page.has_content?("HTTP Verb(s) associated used")
      # assert page.has_content?("Three most popular referrers")
      # assert page.has_content?("Three most popular user agents")
    end
  end



end
