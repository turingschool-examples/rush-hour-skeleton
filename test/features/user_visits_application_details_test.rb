require_relative '../test_helper'

class UserVisitsApplicationDetailsTest < FeatureTest
  include PayloadPrep

  def setup_testing_environment
    post '/sources', {rootUrl: 'http://jumpstartlab.com', identifier: 'jumpstartlab'}

    post '/sources/jumpstartlab/data', payload_params1
    post '/sources/jumpstartlab/data', payload_params2
    post '/sources/jumpstartlab/data', payload_params3

    visit '/sources/jumpstartlab'
  end

  def test_user_can_view_most_requested_urls
    setup_testing_environment

    within('#mvp_urls') do
      assert page.has_content?('URL Popularity Contest')
      assert page.has_content?('blog')
    end
  end

  def test_user_can_view_most_requested_browsers
    setup_testing_environment

    within('#mvp_browsers') do
      assert page.has_content?('Browser Popularity Contest')
      assert page.has_content?('Chrome')
    end
  end

  def test_user_can_view_most_requested_os
    setup_testing_environment

    within('#mvp_os') do
      assert page.has_content?('OS Popularity Contest')
      assert page.has_content?('Macintosh')
    end
  end

  def test_user_can_view_most_requested_screen_resolutions
    setup_testing_environment

    within('#mvp_resolution') do
      assert page.has_content?('Screen Resolution Popularity Contest')
      assert page.has_content?('12 x 120')
    end
  end

  def test_user_can_view_most_requested_screen_resolutions
    setup_testing_environment
    within('#avg_response') do
      assert page.has_content?('Average Response Time')
      assert page.has_content?('38')
    end
  end

  def test_user_can_view_links_to_URL_data
    setup_testing_environment
    within('#mvp_urls') do
      assert page.has_content?('URL Popularity Contest')
    end

    click_link('url_data_response_http://jumpstartlab.com/blog')

    refute page.has_content?('URL Popularity Contest')
  end

  def test_user_can_view_event_data
    setup_testing_environment
    within('#aggregate_event_data') do
      assert page.has_content?('View Event Data')
    end

    click_link('event_data')

    refute page.has_content?('URL Popularity Contest')
  end

  # def test_user_sees_identifier_does_not_exist_when_not_registered
  #   visit '/sources/jumpstartlab'
  #   within('#unregistered_identifier') do
  #     assert page_has_content?('Jumpstartlab is not registered')
  #   end
  # end

end
