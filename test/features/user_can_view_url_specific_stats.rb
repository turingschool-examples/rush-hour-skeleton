require_relative '../test_helper'

class UserCanViewUrlSpecificStats < FeatureTest
  def test_successfully
    # As a non logged in user
    # When I visit the home page
    visit '/'
    # and I enter my user name
    fill_in('app[identifier]', with 'jumpstartlab')
    # And I click submit
    click_button "Submit"
    # then I should see the stats page
    assert_equal '/sources/jumpstartlab', current_path
    # and I click on a specific url link
    click_link ('http://jumpstartlab.com/about')
    assert_equal '/sources/jumpstartlab/urls/about', current_path
    # then I should see a page that shows the url specific stats
    within("#url-specific-stats") do
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
    # As a non logged in user
    # When I visit the home page
    visit '/'
    # and I enter my user name
    fill_in('app[identifier]', with 'jumpstartlab')
    # And I click submit
    click_button "Submit"
    # then I should see the stats page
    assert_equal '/sources/jumpstartlab', current_path
    # and if I enter a url that does not exists
    assert_equal '/error', current_path
    # then I should see an error message
    within('#missing-url') do
      assert page.has_content? "Error, that url does not exist"
    end
  end
end
