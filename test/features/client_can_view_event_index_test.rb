
require './test/test_helper'

class ClientCanViewEventIndexTest < FeatureTest

  def setup
  register_site
  @url = Url.create(path: "http://jumpstartlab.com/blog", site_id: @site.id)
  browser = Browser.create(name: "Chrome")
  platform = Platform.create(name: "Macintosh")
  referrer = Referrer.create(path: "espn.com")
  request_type = RequestType.create(verb: "GET")
  event1 = Event.create(name: "socialLogin")
  event2 = Event.create(name: "register")

  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 18:38:28 -0700", responded_in: 37, event_id: event1.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 19:38:28 -0700", responded_in: 50, event_id: event1.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 18:38:28 -0700", responded_in: 50, event_id: event2.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  end

  def test_can_see_events_in_order
      visit '/sources/jumpstartlab/events'

      assert page.has_content?("socialLogin")
      assert page.has_content?("2")
      assert page.has_content?("register")
      assert page.has_content?("1")
  end

  def test_can_clink_link_to_event_specific_data
    visit '/sources/jumpstartlab/events'

    click_link("socialLogin")

    assert ("/sources/jumpstartlab/events/socialLogin"), current_path
  end

end
