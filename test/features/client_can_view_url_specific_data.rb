require_relative '../test_helper'

class UserCanViewUrlSpecificDataTest < FeatureTest

  def test_user_can_view_url_specific_data
  # As a user
  # When I visit the sources/:IDENTIFIER page
    visit "/sources/jumpstartlab/urls/blog"
    #Then I should see the a table of payload data
    assert page.has_css?(".col-md-12")
    assert page.has_css?(".container-fluid")
    assert page.has_css?("#all_times")
    assert page.has_css?("#agents")

    assert page.has_content?("URL Specific Data")
    assert page.has_content?("Response Times")
    assert page.has_content?("All Response Times")
    assert page.has_content?("Popular Referrers")
    assert page.has_content?("Popular Agents")
  end
end
