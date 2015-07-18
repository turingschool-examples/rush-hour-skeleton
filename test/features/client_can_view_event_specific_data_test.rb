require './test/test_helper'

class ClientCanViewEventSpecificDataTest < FeatureTest

  def setup
  register_site
  @url = Url.create(path: "http://jumpstartlab.com/blog", site_id: @site.id)
  browser = Browser.create(name: "Chrome")
  platform = Platform.create(name: "Macintosh")
  referrer = Referrer.create(path: "espn.com")
  request_type = RequestType.create(verb: "GET")
  event = Event.create(name: "socialLogin")

  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 18:38:28 -0700", responded_in: 37, event_id: event.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 21:38:28 -0700", responded_in: 50, event_id: event.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 03:38:28 -0700", responded_in: 50, event_id: event.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 01:38:28 -0700", responded_in: 37, event_id: event.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 01:38:28 -0700", responded_in: 50, event_id: event.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 10:38:28 -0700", responded_in: 50, event_id: event.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 10:38:28 -0700", responded_in: 37, event_id: event.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 10:38:28 -0700", responded_in: 50, event_id: event.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 10:38:28 -0700", responded_in: 50, event_id: event.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 10:38:28 -0700", responded_in: 50, event_id: event.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 11:38:28 -0700", responded_in: 50, event_id: event.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 18:38:28 -0700", responded_in: 37, event_id: event.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 21:38:28 -0700", responded_in: 50, event_id: event.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  Payload.create(url_id: @url.id, resolution_width: "900", resolution_height: "1100",requested_at: "2013-02-16 05:38:28 -0700", responded_in: 50, event_id: event.id, referrer_id: referrer.id, browser_id: browser.id, platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")
  end

  def test_can_see_events_by_hour
    visit '/sources/jumpstartlab/events/socialLogin'

    assert page.has_content?("12 AM")
    data = page.all("td")
    assert data[10].has_content?("5")
  end
end
