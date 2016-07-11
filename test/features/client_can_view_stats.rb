require_relative '../test_helper'

class UserCanViewStatsTest < FeatureTest
  include TestHelpers

  def setup
    create_payload(1)
  end

  def test_user_can_view_stats
  # As a user
  # When I visit the sources/:IDENTIFIER page
    visit "/sources/google"
    #Then I should see the a table of payload data
    save_and_open_page
    assert page.has_css?(".col-md-12")
    assert page.has_css?(".container-fluid")
    assert page.has_css?("#response_times")
    assert page.has_css?("#requests_and_agents")
    assert page.has_css?("#resolutions")

    assert page.has_content?("Average Response Time")
    assert page.has_content?("Minimum Response Time")
    assert page.has_content?("Maximum Response Time")
    assert page.has_content?("Most Frequent Request Type")
    assert page.has_content?("All HTTP Verbs Used")
    assert page.has_content?("URL Requests - Most to Least")
    assert page.has_content?("Operating Systems")
    assert page.has_content?("Browsers")
    assert page.has_content?("All Screen Resolutions")
  end
end
