require './test/test_helper'

class UrlSpecificHTTPVerbsTest < FeatureTest
  def setup
    register_site
    @url = Url.create(path: "http://jumpstartlab.com/blog", site_id: @site.id)
    browser = Browser.create(name: "Chrome")
    platform = Platform.create(name: "Macintosh")
    referrer = Referrer.create(path: "espn.com")
    request_type1 = RequestType.create(verb: "GET")
    request_type2 = RequestType.create(verb: "POST")
    Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type1.id, sha: "alskdjflkj")
    Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 50, event_id: 1, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type1.id, sha: "alskdjflkj")
    Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 150, event_id: 1, referrer_id: referrer.id,browser_id: browser.id, platform_id: platform.id, request_type_id: request_type2.id, sha: "alskdjflkj")
  end

  def test_returns_http_verbs
    visit '/sources/jumpstartlab/urls/blog'

    assert page.has_content?("GET")
    assert page.has_content?("2")
    assert page.has_content?("POST")
    assert page.has_content?("1")
  end

  def test_returns_error_message_if_path_not_in_db
    visit '/sources/jumpstartlab/urls/joshrulez'

    assert page.has_content?("The URL path, /joshrulez, has not been requested.")
  end
end
