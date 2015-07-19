require './test/test_helper'

class ClientCanViewBrowserDataTest < FeatureTest

  def test_view_one_browser
    register_site
    Url.create(path: "http://jumpstartlab.com/blog", site_id: @site.id)
    browser = Browser.create(name: "Chrome")
    platform = Platform.create(name: "Macintosh")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: browser.id,
                   platform_id: platform.id, request_type_id: 1, sha: "alskdjflkj")

    visit '/sources/jumpstartlab'

    assert has_content?("Chrome")
  end

  def test_view_multiple_browsers
    register_site
    Url.create(path: "http://jumpstartlab.com/blog", site_id: @site.id)
    browser1 = Browser.create(name: "Mozilla")
    browser2 = Browser.create(name: "Chrome")
    browser3 = Browser.find_or_create_by(name: "Chrome")
    platform = Platform.create(name: "Macintosh")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: browser1.id,
                   platform_id: platform.id, request_type_id: 1, sha: "alskdjfdflkj")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: browser2.id,
                   platform_id: platform.id, request_type_id: 1, sha: "alskdjfslkj")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: browser3.id,
                   platform_id: platform.id, request_type_id: 1, sha: "alskdfaedjflkj")

    visit '/sources/jumpstartlab'

    assert has_content?("Mozilla")
    assert has_content?("Chrome")
  end
end
