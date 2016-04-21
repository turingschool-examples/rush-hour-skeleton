require_relative '../test_helper'

class UserCanSeeAnalyticsDashboardTest < FeatureTest
  include TestHelpers

  def client_create
    Client.create({"identifier"=> "jumpstartlab",
                    "root_url"   => "http://jumpstartlab.com"})
    end

  def test_user_can_see_the_dashboard_page
    client_create
    visit "/sources/jumpstartlab"


    assert_equal "/sources/jumpstartlab", current_path
  end

  def test_user_can_see_payload_dashboard
    # client_create
    # setup_1

    client_setup
    payload_setup1

    visit '/sources/jumpstartlab'
    assert_equal "/sources/jumpstartlab", current_path
    save_and_open_page

    assert page.has_content?("Average Response time across all requests: ")
    assert page.has_content?("Max Response time across all requests:  ")
    assert page.has_content?("Min Response time across all requests: ")
    assert page.has_content?("Most frequent request type: ")
    assert page.has_content?("List of all HTTP verbs used: ")
    assert page.has_content?("List of URLs listed from most requested to least requested: ")
    assert page.has_content?("Web browser breakdown across all requests: ")
    assert page.has_content?("OS breakdown across all requests")
    assert page.has_content?("Screen Resolutions across all requests: ")
  end

end
