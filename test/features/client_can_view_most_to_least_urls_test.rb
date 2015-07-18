require './test/test_helper'

class ClientCanViewMostToLeastURLsTest < FeatureTest

  def test_that_an_identifier_does_not_exist
    visit '/sources/jumpstartlab'

    assert page.has_content?("The identifier, jumpstartlab, does not exist."), "Expected message but didn't receive a message"
  end

  def test_that_an_identifier_exists
    register_site

    visit '/sources/jumpstartlab'

    assert page.has_content?("Hello, jumpstartlab"), "Page does not have content jumpstartlab"
  end

  def test_identifier_has_a_url
    register_site
    Url.create(path: "http://jumpstartlab.com/blog", site_id: @site.id)
    Browser.create(name: "Chrome")
    Platform.create(name: "Macintosh")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "alskdjflkj")

    visit '/sources/jumpstartlab'

    assert page.has_content?("http://jumpstartlab.com/blog")
  end

  def test_that_no_urls_have_been_visited
    register_site

    visit '/sources/jumpstartlab'

    assert page.has_content?("No URLs visited")
  end

  def test_identifier_has_3_different_urls
    register_site
    Url.create(path: "http://jumpstartlab.com/blog/1", site_id: @site.id)
    Url.create(path: "http://jumpstartlab.com/blog/2", site_id: @site.id)
    Url.create(path: "http://jumpstartlab.com/blog/3", site_id: @site.id)
    Browser.create(name: "Chrome")
    Platform.create(name: "Macintosh")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "alskdjflkj")
    Payload.create(url_id: 2, resolution_width: "900", resolution_height: "1100",requested_at: "someddfftime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "aldddddddddddkdjflkj")
    Payload.create(url_id: 3, resolution_width: "900", resolution_height: "1100",requested_at: "someasdftime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "alddddddskdjflkj")

    visit '/sources/jumpstartlab'

    assert page.has_content?("http://jumpstartlab.com/blog/1")
    assert page.has_content?("http://jumpstartlab.com/blog/2")
    assert page.has_content?("http://jumpstartlab.com/blog/3")
  end

  def test_urls_sorted_most_to_least
    register_site
    url1 = Url.create(path: "http://jumpstartlab.com/blog/1", site_id: @site.id)
    url2 = Url.create(path: "http://jumpstartlab.com/blog/2", site_id: @site.id)
    url3 = Url.create(path: "http://jumpstartlab.com/blog/3", site_id: @site.id)
    Browser.create(name: "Chrome")
    Platform.create(name: "Macintosh")
    Payload.create(url_id: 1, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "alskdjflkj")
    Payload.create(url_id: 2, resolution_width: "900", resolution_height: "1100",requested_at: "someddfftime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "aldddddddddddkdjflkj")
    Payload.create(url_id: 2, resolution_width: "900", resolution_height: "1100",requested_at: "someasdftime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "alddddddskdjflkj")
    Payload.create(url_id: 2, resolution_width: "900", resolution_height: "1100",requested_at: "somfffetime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "aldddddskdjflkj")
    Payload.create(url_id: 2, resolution_width: "900", resolution_height: "1100",requested_at: "soddmetime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "alddddskdjflkj")
    Payload.create(url_id: 2, resolution_width: "900", resolution_height: "1100",requested_at: "sosmetime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "adddskdjflkj")
    Payload.create(url_id: 3, resolution_width: "900", resolution_height: "1100",requested_at: "somasdfsadfetime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "aldskdjflkj")
    Payload.create(url_id: 3, resolution_width: "900", resolution_height: "1100",requested_at: "soasdfmetime", responded_in: 37, event_id: 1, referrer_id: 1, browser_id: 1,
                   platform_id: 1, request_type_id: 1, sha: "alssaasdfkdjflkj")

    visit '/sources/jumpstartlab'

    assert page.has_content?("http://jumpstartlab.com/blog/2")
    assert page.has_content?("http://jumpstartlab.com/blog/3")
    assert page.has_content?("http://jumpstartlab.com/blog/1")
  end

  def test_urls_links_to_proper_route
    register_site
    url = @site.urls.create(path: "http://jumpstartlab.com/blog")
    browser = Browser.create(name: "Chrome")
    platform = Platform.create(name: "Macintosh")
    request_type = RequestType.create(verb: "GET")
    referrer = Referrer.create(path: "espn.com")
    Payload.create(url_id: url.id, resolution_width: "900", resolution_height: "1100",requested_at: "sometime", responded_in: 37, event_id: 1, referrer_id: referrer.id, browser_id: browser.id,
                   platform_id: platform.id, request_type_id: request_type.id, sha: "alskdjflkj")

    visit '/sources/jumpstartlab'
    click_link("http://jumpstartlab.com/blog")

    assert page.has_content?("blog page data")

  end
end
