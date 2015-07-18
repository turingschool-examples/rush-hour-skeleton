require './test/test_helper'

class ClientCanViewUrlAverageResponseTimesTest < FeatureTest

  def test_view_one_url_response_time
    register_site
    Url.create(path: "http://jumpstartlab.com/blog", site_id: @site.id)
    browser = Browser.create(name: "Chrome")
    platform = Platform.create(name: "Macintosh")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: platform.id, request_type_id: 1, sha: "alskdjflkj")

    visit '/sources/jumpstartlab'

    assert has_content?("37")
  end

  def test_view_multiple_url_average_response_time
    register_site
    Url.create(path: "http://jumpstartlab.com/blog/1", site_id: @site.id)
    Url.create(path: "http://jumpstartlab.com/blog/2", site_id: @site.id)
    browser = Browser.create(name: "Chrome")
    platform = Platform.create(name: "Macintosh")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "alskdjfdflkj")
    Payload.create(url_id: 2, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 200, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "alskdjfslkj")
    Payload.create(url_id: 2, resolution_width: "600", resolution_height: "800",requested_at: "sometime", responded_in: 400, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "alskdfaedjflkj")

    visit '/sources/jumpstartlab'

    assert has_content?("37")
    assert has_content?("300")
  end
end