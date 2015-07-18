require './test/test_helper'

class UrlSpecificResponseTimesTest < FeatureTest
  def setup
    register_site
    @url = Url.create(path: "http://jumpstartlab.com/blog", site_id: @site.id)
    @browser = Browser.create(name: "Chrome")
    @platform = Platform.create(name: "Macintosh")

    Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at:                                    "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: @browser.id, platform_id: @platform.id, request_type_id: 1, sha: "alskdjflkj")
    Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at:                                    "sometime", responded_in: 50, event_id: 1, referrer_id: 1, browser_id: @browser.id, platform_id: @platform.id, request_type_id: 1, sha: "alskdjflkj")
    Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at:                                    "sometime", responded_in: 150, event_id: 1, referrer_id: 1, browser_id: @browser.id, platform_id: @platform.id, request_type_id: 1, sha: "alskdjflkj")
  end

  def test_returns_fastest_response_time_for_a_url
    visit '/sources/jumpstartlab/urls/blog'

    assert page.has_content?("37")
  end

  def test_returns_slowest_response_time_for_a_url
    visit '/sources/jumpstartlab/urls/blog'

    assert page.has_content?("150")
  end

  def test_returns_average_response_time_for_a_url
    visit '/sources/jumpstartlab/urls/blog'

    assert page.has_content?("79.0")
  end

  def test_returns_error_message_if_path_not_in_db
    visit '/sources/jumpstartlab/urls/joshrulez'

    assert page.has_content?("The URL path, /joshrulez, has not been requested.")
  end
end
