require './test/test_helper'

class ClientCanViewScreenResolutionDataTest < FeatureTest

  def test_view_one_screen_resolution
    register_site
    Url.create(path: "http://jumpstartlab.com/blog", site_id: @site.id)
    browser = Browser.create(name: "Chrome")
    platform = Platform.create(name: "Macintosh")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: platform.id, request_type_id: 1, sha: "alskdjflkj")

    visit '/sources/jumpstartlab'

    assert has_content?("900x1100")
  end

  def test_view_multiple_platforms
    register_site
    Url.create(path: "http://jumpstartlab.com/blog", site_id: @site.id)
    browser = Browser.create(name: "Chrome")
    platform = Platform.create(name: "Macintosh")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "alskdjfdflkj")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "alskdjfslkj")
    Payload.create(url_id: 1, resolution_width: "600", resolution_height: "800",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "alskdfaedjflkj")

    visit '/sources/jumpstartlab'

    assert has_content?("900x1100")
    assert has_content?("600x800")
  end
end