require './test/test_helper'

class UserViewsApplicationDetailsTest < FeatureTest

  def test_the_page_displays_the_most_requested_URLS_to_least_requested_URLS
    visit 'http://yourapplication:port/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#urls') do
    assert page.has_content?('http://jumpstartlab.com')
   end
  end

  def test_the_page_displays_web_browser_breakdown_across_all_requests
    visit 'http://yourapplication:port/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#browser-breakdown') do
    assert page.has_content?('Chrome')
    end
  end

  def test_page_displays_an_OS_breakdown_across_all_requests_
    visit 'http://yourapplication:port/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#OS-breakdown') do
    assert page.has_content?('Macintosh')
    end
  end

  def test_page_displays_screen_resolutions_across_all_requests
    visit 'http://yourapplication:port/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#screen-resolutions') do
    assert page.has_content?('1920 x 1080')
    end
  end

  def test_page_displays_longest_average_response_time_per_URL_to_shortest_average_response_time_per_URL
    visit 'http://yourapplication:port/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#response-times') do
    assert page.has_content?('37, http://jumpstartlab.com')
    end
  end

  def test_page_displays_hyperlinks_of_each_url_to_view_url_specific_data
    visit 'http://yourapplication:port/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#hyperlinks') do
    assert page.has_content?('http://jumpstartlab.com/blog')
    end
  end




end

# As a client
# When I visit http://yourapplication:port/sources/IDENTIFIER
# And that  identifer exists
# xxxxx Then I should see a page that displays the most requested URLS to least requested URLS (url)
# xxxxx And I should see a web browser breakdown across all requests (userAgent)
# xxxxx And I should see an OS breakdown across all requests (userAgent)
# xxxxx And I should see Screen Resolutions across all requests (resolutionWidth x resolutionHeight)
# xxxxx And I should see a Longest, average response time per URL to shortest, average response time per URL
# xxxxx And I should see a Hyperlinks of each url to view url specific data
# And I should see a Hyperlink to view aggregate event data
#
# As a client
# When I visit http://yourapplication:port/sources/IDENTIFIER
# And the identifier does not exist
# Then I should see a "Some notification message"
