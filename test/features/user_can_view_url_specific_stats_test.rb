require_relative '../test_helper'

class UserCanViewUrlSpecificStats < FeatureTest

  def test_successfully_shows_data
    create_9_payloads_for_url_stats
    # As a registered user
    # When I visit my user page
    # visit '/sources/jumpstartlab'
    # and I click on the urls link
    # click_link ("#urls")
    # assert_equal '/sources/jumpstartlab/urls', current_path
    # # and I click on a specific url link
    # click_link ('/blog')
    # assert_equal '/sources/jumpstartlab/urls/blog', current_path

    # when I visit a page for a specific url
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

  def test_url_does_not_exists
    create_9_payloads_for_url_stats

    visit '/sources/jumpstartlab/urls/fake'
    # then I should see an error message
    assert_equal '/missing-url', current_path
    within('.missing-url') do
      assert page.has_content? "This url has not been requested"
    end
  end
end
