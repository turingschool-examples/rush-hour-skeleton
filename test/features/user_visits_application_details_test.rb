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
    save_and_open_page
    within('#avg_response') do
      assert page.has_content?('Average Response Time')
      assert page.has_content?('27')
    end
  end

  def test_user_can_view_links_to_URL_data
    setup_testing_environment
    within('#url_data') do
      assert page.has_content?('URL Popularity Contest')
    end

    click_link('url_data')

    refute page.has_content?('URL Popularity Contest')
  end

end
