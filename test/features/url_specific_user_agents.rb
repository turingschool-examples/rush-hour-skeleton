require './test/test_helper'

class UrlSpecificUserAgentsTest < FeatureTest
  def setup
    register_site
    @url = Url.create(path: "http://jumpstartlab.com/blog", site_id: @site.id)
    request_type = RequestType.create(verb: "GET")
    referrer = Referrer.create(path: "http://espn.com")
    platform1 = Platform.create(name: "Macintosh")
    platform2 = Platform.create(name: "Macintosh")
    platform3 = Platform.create(name: "Windows")
    platform1 = Platform.create(name: "Windows")
    browser1 = Browser.create(name: "Chrome")
    browser2 = Browser.create(name: "Chrome")
    browser3 = Browser.create(name: "Mozilla")

    Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: referrer.id, browser_id: browser1.id, platform_id: platform1.id, request_type_id: request_type.id, sha: "alskdjflkj")
    Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 50, event_id: 1, referrer_id: referrer.id, browser_id: browser2.id, platform_id: platform2.id, request_type_id: request_type.id, sha: "alskdjflkj")
    Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 150,event_id: 1,referrer_id: referrer.id, browser_id: browser3.id, platform_id: platform3.id, request_type_id: request_type.id, sha: "alskdjflkj")
  end

  def test_returns_http_verbs
    visit '/sources/jumpstartlab/urls/blog'

    assert page.has_content?("Chrome")
    assert page.has_content?("2")
    assert page.has_content?("Mozilla")
    assert page.has_content?("1")
    assert page.has_content?("Macintosh")
    assert page.has_content?("2")
    assert page.has_content?("Windows")
    assert page.has_content?("1")
  end

  def test_returns_error_message_if_path_not_in_db
    visit '/sources/jumpstartlab/urls/joshrulez'

    assert page.has_content?("The URL path, /joshrulez, has not been requested.")
  end
end