require_relative '../test_helper'

class UserCanClickOnURLOnDashboard < FeatureTest
  include TestHelpers
  include Rack::Test::Methods

  def test_invalid_client_results_in_error_page
    path = '/sources/jumpstartlab'
    visit path

    assert_equal path, current_path
    within("h2") do
      assert page.has_content?("Client not registered")
    end
  end

  def test_user_can_follow_a_link_for_a_url
    register_client
    referrer_data

    params = {
      "url": "http://google.com/search",
      "requestedAt": "2013-01-16 23:38:28 -0700",
      "respondedIn": 90,
      "referredBy": "http://apple.com/research",
      "requestType": "GET",
      "parameters": ["what","huh"],
      "eventName":  "show",
      "userAgent": "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth": "420",
      "resolutionHeight": "700",
      "ip": "59.29.38.203"
    }

    post '/sources/jumpstartlab/data', params
    save_and_open_page
    visit path

    assert_equal path, current_path

    click_link "http://google.com/search"
    assert_equal "/sources/jumpstartlab/urls/search", current_path
  end

  # def test_user_gets_error_page_when_client_has_received_no_payload_requests
  #   Client.create(identifier: "test", root_url: "http://jumpstartlab.com")
  #   path = '/sources/test'
  #   visit path
  #
  #   assert_equal path, current_path
  #
  #   within("h2") do
  #     assert page.has_content?("Client is registered, but no requests have been received")
  #   end
  # end

  # def test_viewer_can_visit_dashboard_and_view_stats
  #   referrer_data
  #   path = '/sources/jumpstartlab'
  #   visit path
  #
  #   setup_data
  #
  #   assert_equal path, current_path
  #   within("#identifier") do
  #     assert page.has_content?("Jumpstartlab")
  #   end
  #
  #   within('#analytics') do
  #     assert page.has_content?("Average Response time across all requests: 25.0")
  #     assert page.has_content?("Max Response time across all requests: 40")
  #     assert page.has_content?("Min Response time across all requests: 10")
  #     assert page.has_content?("Most frequent request type: GET")
  #     assert page.has_content?("List of all HTTP verbs used: [\"GET\", \"POST\"]")
  #     assert page.has_content?("List of URLs listed from most requested to least requested: \"http://turing.io\"")
  #     assert page.has_content?("Web browser breakdown across all requests: [\"Mozilla\", \"Opera\", \"Chrome\"]")
  #     assert page.has_content?("OS breakdown across all requests: [\"Windows\", \"Webkit\", \"Macintosh\"]")
  #     assert page.has_content?("Screen Resolutions across all requests (resolutionWidth x resolutionHeight): [\"2560x1440\", \"1920x1280\"]")
  #   end
  # end
  #
  # def test_viewer_can_visit_dashboard_and_view_stats_different_client
  #   referrer_data
  #   path = '/sources/turing'
  #   visit path
  #
  #   setup_data
  #
  #   assert_equal path, current_path
  #   within("#identifier") do
  #     assert page.has_content?("Turing")
  #   end
  #
  #   within('#analytics') do
  #     assert page.has_content?("Average Response time across all requests: 10.0")
  #     assert page.has_content?("Max Response time across all requests: 10")
  #     assert page.has_content?("Min Response time across all requests: 10")
  #     assert page.has_content?("Most frequent request type: GET")
  #     assert page.has_content?("List of all HTTP verbs used: [\"GET\"]")
  #     # assert page.has_content?("List of URLs listed from most requested to least requested: [\"http://turing.io\"]")
  #     assert page.has_content?("Web browser breakdown across all requests: [\"Chrome\"]")
  #     assert page.has_content?("OS breakdown across all requests: [\"Macintosh\"]")
  #     assert page.has_content?("Screen Resolutions across all requests (resolutionWidth x resolutionHeight): [\"1920x1280\"]")
  #   end
  # end

end
