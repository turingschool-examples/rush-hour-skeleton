require_relative '../test_helper'

class UserVisitsApplicationDetailsTest < FeatureTest
  include PayloadPrep

  def test_user_can_view_most_requested_urls
    post '/sources', {rootUrl: 'http://jumpstartlab.com', identifier: 'jumpstartlab'}

    post '/sources/jumpstartlab/data', payload_params1
    post '/sources/jumpstartlab/data', payload_params2
    post '/sources/jumpstartlab/data', payload_params3

    visit '/sources/jumpstartlab'

    within('#mvp_urls') do
      assert page.has_content?('URL Popularity Contest')
      assert page.has_content?('blog')
    end
  end

  def test_user_can_view_most_requested_browsers
    post '/sources', {rootUrl: 'http://jumpstartlab.com', identifier: 'jumpstartlab'}

    post '/sources/jumpstartlab/data', payload_params1
    post '/sources/jumpstartlab/data', payload_params2
    post '/sources/jumpstartlab/data', payload_params3

    visit '/sources/jumpstartlab'
    save_and_open_page
    within('#mvp_browsers') do
      assert page.has_content?('Browser Popularity Contest')
      assert page.has_content?('Chrome')
    end
  end

end
