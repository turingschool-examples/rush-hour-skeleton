require_relative '../test_helper'

class ClientStatsTest < FeatureTest

  def test_client_can_see_own_page
#   when I visit the home page
    visit '/'
#   and I enter my client name on the form
    fill_in('app[identifier]'), with 'microsoft')
#   and I click the submit button
    click_button "Submit"
#   then I should see stats for my web pages
    assert_equal '/sources/microsoft', current_path
    within('.client_stats') do
      assert page.has_content? 'Average Response Time'
      assert page.has_content? 'Max Response Time'
      assert page.has_content? 'Min Response Time'
      assert page.has_content? 'Most Frequent Request Type'
      assert page.has_content? 'List of all HTTP verbs used'
      assert page.has_content? 'List of URLs from most to least requested'
      assert page.has_content? 'Web Browser Breakdown'
      assert page.has_content? 'OS Breakdown'
      assert page.has_content? 'Screen Resolutions Used'
    end
  end
end
