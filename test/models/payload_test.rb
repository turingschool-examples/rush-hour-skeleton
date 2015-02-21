require './test/test_helper'
class PayloadTest < Minitest::Test

  def test_creates_empty_payload
    Payload.create
    assert_equal 1, Payload.count
  end

  def test_it_has_correct_attributes
    payload = Payload.create({url_id: 1,
                              requested_at: "tuesday",
                              responded_in: 37,
                              referrer_id: 2,
                              request_type_id: 3,
                              ip_address_id: 4,
                              event_id: 5,
                              resolution_id: 6,
                              browser_id: 7,
                              os_id: 8,
                              source_id: 9,
                              raw_data: "a very long string of json"
                              })
    assert_equal 1, payload.url_id
    assert_equal "tuesday", payload.requested_at
    assert_equal 37, payload.responded_in
    assert_equal 2, payload.referrer_id
    assert_equal 3, payload.request_type_id
    assert_equal 4, payload.ip_address_id
    assert_equal 5, payload.event_id
    assert_equal 6, payload.resolution_id
    assert_equal 7, payload.browser_id
    assert_equal 8, payload.os_id
    assert_equal 9, payload.source_id
    assert_equal "a very long string of json", payload.raw_data
  end

  def test_belongs_to_url
    url = Url.create(address: "http://jumpstartlab.com/blog")
    payload = Payload.create({url_id: 1})

    assert_equal "http://jumpstartlab.com/blog", payload.url.address
  end

  def test_belongs_to_referrer_id
    referrer = Referrer.create(name: "www.referrer.com")
    payload = Payload.create({referrer_id: 1})

    assert_equal "www.referrer.com", payload.referrer.name
  end

  def test_belongs_to_request_type
    request_type = RequestType.create(verb: "GET")
    payload = Payload.create(request_type_id: 1)

    assert_equal "GET", payload.request_type.verb
  end

  def test_belongs_to_ip_address
    ip_address = IpAddress.create(address: "63.29.38.211")
    payload = Payload.create(ip_address_id: 1)

    assert_equal "63.29.38.211", payload.ip_address.address
  end

  def test_belongs_to_event
    event = Event.create(name: "socialLogin")
    payload = Payload.create(event_id: 1)

    assert_equal "socialLogin", payload.event.name
  end

  def test_belongs_to_resolution
    resolution = Resolution.create({width: "1920", height: "1280"})
    payload = Payload.create(resolution_id: 1)

    assert_equal "1920", payload.resolution.width
    assert_equal "1280", payload.resolution.height
  end

  def test_it_belongs_to_browser
    browser = Browser.create(name: "Chrome")
    payload = Payload.create(browser_id: 1)

    assert_equal "Chrome", payload.browser.name
  end

  def test_it_belongs_to_os
    os = Os.create(name: "Macintosh")
    payload = Payload.create(os_id: 1)

    assert_equal "Macintosh", payload.os.name
  end

  def test_it_belongs_to_source
    source = Source.create({rootUrl: "http://jumpstartlab.com/blog", identifier: "jumpstartlab"})
    payload = Payload.create(source_id: 1)

    assert_equal "http://jumpstartlab.com/blog", payload.source.rootUrl
    assert_equal "jumpstartlab", payload.source.identifier
  end

  def teardown
    DatabaseCleaner.clean
  end

end
