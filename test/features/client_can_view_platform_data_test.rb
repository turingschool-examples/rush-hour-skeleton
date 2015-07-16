require './test/test_helper'

class ClientCanViewPlatformDataTest < FeatureTest

  def test_view_one_platform
    register_site
    Url.create(path: "http://jumpstartlab.com/blog", site_id: @site.id)
    browser = Browser.create(name: "Chrome")
    platform = Platform.create(name: "Macintosh")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: browser.id,
                   platform_id: platform.id, request_type_id: 1, sha: "alskdjflkj")

    visit '/sources/jumpstartlab'

    assert has_content?("Macintosh")
  end

  def test_view_multiple_platforms
    register_site
    Url.create(path: "http://jumpstartlab.com/blog", site_id: @site.id)
    browser = Browser.create(name: "Chrome")
    platform1 = Platform.create(name: "Windows 95")
    platform2 = Platform.create(name: "Macintosh")
    platform3 = Platform.find_or_create_by(name: "Macintosh")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: browser.id,
                   platform_id: platform1.id, request_type_id: 1, sha: "alskdjfdflkj")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: browser.id,
                   platform_id: platform2.id, request_type_id: 1, sha: "alskdjfslkj")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: browser.id,
                   platform_id: platform3.id, request_type_id: 1, sha: "alskdfaedjflkj")

    visit '/sources/jumpstartlab'

    assert has_content?("Macintosh")
    assert has_content?("Windows 95")
  end
end
