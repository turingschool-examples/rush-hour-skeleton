require './test/test_helper'

class UserViewsApplicationDetailsTest < FeatureTest

  def setup
    populate
  end

  def test_the_page_displays_the_correct_user
    visit 'http://localhost:9393/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    refute page.has_content?("Error")
    assert page.has_content?('jumpstartlab')
  end

  def test_page_displays_error_message_when_identifier_does_not_exist
    visit 'http://localhost:9393/sources/bad_identifier'
    assert_equal '/sources/bad_identifier', current_path
    assert page.has_content?('Error Page')
  end

  def test_the_page_displays_the_most_requested_URLS_to_least_requested_URLS
    visit 'http://localhost:9393/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#urls') do
      assert page.has_content?('http://jumpstartlab.com/blog')
      assert_equal 'http://jumpstartlab.com/blog', page.first('li').text
    end
  end

  def test_the_page_displays_web_browser_breakdown_across_all_requests
    visit 'http://localhost:9393/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    assert page.has_content?('Chrome')
  end

  def test_page_displays_an_OS_breakdown_across_all_requests
    visit 'http://localhost:9393/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    assert page.has_content?('Macintosh')
  end

  def test_page_displays_screen_resolutions_across_all_requests
    visit 'http://localhost:9393/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    assert page.has_content?('1920 x 1280')
  end

  def test_page_displays_longest_average_response_time_per_URL_to_shortest_average_response_time_per_URL
    skip
    visit 'http://localhost:9393/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    assert page.has_content?('37, http://jumpstartlab.com')
  end

  def test_page_displays_hyperlinks_of_each_url_to_view_url_specific_data
    skip
    visit 'http://localhost:9393/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#url_links') do
      assert page.has_content?('http://jumpstartlab.com/blog')
    end
  end

  def test_page_displays_hyperlink_to_view_aggregate_event_data
    skip
    visit 'http://localhost:9393/sources/jumpstartlab'
    assert_equal '/sources/jumpstartlab', current_path
    within('#event_links') do
      assert page.has_content?('http://jumpstartlab.com/events')
    end
  end

end
