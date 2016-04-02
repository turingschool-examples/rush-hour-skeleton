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
      assert page.has_content?("Average Response time across all requests")
      assert page.has_content?("Max Response time across all requests")
      assert page.has_content?("Min Response time across all requests")
      assert page.has_content?("Most frequent request type")
      assert page.has_content?("List of all HTTP verbs used")
      assert page.has_content?("List of URLs listed from most requested to least requested")
      assert page.has_content?("Web browser breakdown across all requests")
      assert page.has_content?("OS breakdown across all requests")
      assert page.has_content?("Screen Resolutions across all requests (resolutionWidth x resolutionHeight)")
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
    referrer_data
    path = '/sources/jumpstartlab'
    visit path

    setup_data

    assert_equal path, current_path
    within("#identifier") do
      assert page.has_content?("Jumpstartlab")
    end

    within('#analytics') do
      assert page.has_content?("Average Response time across all requests: 25.0")
      assert page.has_content?("Max Response time across all requests: 40")
      assert page.has_content?("Min Response time across all requests: 10")
      assert page.has_content?("Most frequent request type: GET")
      assert page.has_content?("List of all HTTP verbs used: [\"GET\", \"POST\"]")
      assert page.has_content?("List of URLs listed from most requested to least requested: [\"http://turing.io\"]")
      assert page.has_content?("Web browser breakdown across all requests: [\"Mozilla\", \"Opera\", \"Chrome\"]")
      assert page.has_content?("OS breakdown across all requests: [\"Windows\", \"Webkit\", \"Macintosh\"]")
      assert page.has_content?("Screen Resolutions across all requests (resolutionWidth x resolutionHeight): [\"2560x1440\", \"1920x1280\"]")
    end
  end

  def test_viewer_can_visit_dashboard_and_view_stats_different_client
    referrer_data
    path = '/sources/turing'
    visit path

    setup_data

    assert_equal path, current_path
    within("#identifier") do
      assert page.has_content?("Turing")
    end

    within('#analytics') do
      assert page.has_content?("Average Response time across all requests: 10.0")
      assert page.has_content?("Max Response time across all requests: 10")
      assert page.has_content?("Min Response time across all requests: 10")
      assert page.has_content?("Most frequent request type: GET")
      assert page.has_content?("List of all HTTP verbs used: [\"GET\"]")
      assert page.has_content?("List of URLs listed from most requested to least requested: [\"http://turing.io\"]")
      assert page.has_content?("Web browser breakdown across all requests: [\"Chrome\"]")
      assert page.has_content?("OS breakdown across all requests: [\"Macintosh\"]")
      assert page.has_content?("Screen Resolutions across all requests (resolutionWidth x resolutionHeight): [\"1920x1280\"]")
    end
  end
end
