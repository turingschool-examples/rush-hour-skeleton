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
    skip
    visit 'http://yourapplication:port/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#browser-breakdown') do
      assert page.has_content?('Chrome')
    end
  end

  def test_page_displays_an_OS_breakdown_across_all_requests
    skip
    visit 'http://yourapplication:port/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#OS-breakdown') do
      assert page.has_content?('Macintosh')
    end
  end

  def test_page_displays_screen_resolutions_across_all_requests
    skip
    visit 'http://yourapplication:port/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#screen-resolutions') do
      assert page.has_content?('1920 x 1080')
    end
  end

  def test_page_displays_longest_average_response_time_per_URL_to_shortest_average_response_time_per_URL
    skip
    visit 'http://yourapplication:port/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#response-times') do
      assert page.has_content?('37, http://jumpstartlab.com')
    end
  end

  def test_page_displays_hyperlinks_of_each_url_to_view_url_specific_data
    skip
    visit 'http://yourapplication:port/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#url_links') do
      assert page.has_content?('http://jumpstartlab.com/blog')
    end
  end

  def test_page_displays_hyperlink_to_view_aggregate_event_data
    skip
    visit 'http://yourapplication:port/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#event_links') do
      assert page.has_content?('http://jumpstartlab.com/events')
    end
  end

  def test_page_displays_message_when_identifier_does_not_exist
    skip
    visit 'http://yourapplication:port/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    assert page.has_content?('You havent registered.')
  end

end
