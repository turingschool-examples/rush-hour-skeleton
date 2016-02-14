require_relative '../test_helper'

class UserCanViewUrlSpecificStats < FeatureTest

  def test_successfully_shows_data
    # skip
    creates_9_payloads
    # As a registered user
    # When I visit my user page
    # visit '/sources/jumpstartlab'
    # # and I click on a specific url link
    # click_link ('/about')
    # assert_equal '/sources/jumpstartlab/urls/about', current_path

    # change this one links are put on the first page
    visit '/sources/jumpstartlab/urls/blog'

    # then I should see a page that shows the url specific stats
    within(".url-specific-stats") do
      assert page.has_content? "Max Response Time"
      assert page.has_content? "Min Response Time"
      assert page.has_content? "Response Times Across All Requests"
      assert page.has_content? "Average Response Time"
      assert page.has_content? "HTTP Verbs Used"
      assert page.has_content? "Top Three Referrers"
      assert page.has_content? "Top Three User Agents"
    end
  end

  def test_shows_max_response_time
    skip
    creates_9_payloads
    # change this one links are put on the first page
    visit '/sources/jumpstartlab/urls/blog'

    # then I should see a page that shows the url specific stats
    within(".url-specific-stats") do
      assert page.has_content? "Max Response Time"
      assert page.has_content? "37"
    end
  end

  def test_url_does_not_exists
    skip
    # As a registered user
    # When I visit my user page
    visit '/sources/jumpstartlab'
    # and if I enter a url that does not exists
    assert_equal '/error', current_path
    # then I should see an error message
    within('#missing-url') do
      assert page.has_content? "This url has not been requested"
    end
  end
end
