require_relative '../test_helper'

class ClientStatsTest < FeatureTest
  include TestHelpers

  def test_client_can_see_own_page
    create_payload_1
#   when a registered user visits it's homepage
    visit '/sources/jumpstartlab'
#   then I should see stats for my web pages
    assert_equal '/sources/jumpstartlab', current_path
    within('.client-stats') do
      assert page.has_content? 'Average Response Time'
      assert page.has_content? 'Max Response Time'
      assert page.has_content? 'Min Response Time'
      assert page.has_content? 'Most Frequent Request Type'
      assert page.has_content? 'HTTP verbs used on your sites'
      assert page.has_content? 'URLs visited from most to least'
      assert page.has_content? 'Web Browser Breakdown'
      assert page.has_content? 'Operating System Breakdown'
      assert page.has_content? 'Screen Resolution Breakdown'
    end
  end
end
