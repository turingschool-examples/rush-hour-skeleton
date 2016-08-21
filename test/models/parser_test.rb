require_relative "../test_helper"

class ParserTest < Minitest::Test
  include TestHelpers

  def setup
    @string = '{
                "url":"http://jumpstartlab.com/blog",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn":37,
                "referredBy":"http://jumpstartlab.com",
                "requestType":"GET",
                "parameters":[],
                "eventName": "socialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1920",
                "resolutionHeight":"1280",
                "ip":"63.29.38.211"
              }'
  end

  def test_it_parses_json
    parser = Parser.new
    hash = {
              :url=>"http://jumpstartlab.com/blog",
              :requestedAt=>"2013-02-16 21:38:28 -0700",
              :respondedIn=>37,
              :referredBy=>"http://jumpstartlab.com",
              :requestType=>"GET",
              :parameters=>[],
              :eventName=>"socialLogin",
              :userAgent=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
              :resolutionWidth=>"1920",
              :resolutionHeight=>"1280",
              :ip=>"63.29.38.211"
            }
    assert_equal hash, parser.json(@string)
  end

  def test_create_url_table
    parser = Parser.new
    url = "http://jumpstartlab.com/blog"
    url1 = "www.google.com"

    first = parser.create_url(url)
    second = parser.create_url(url1)

    assert_equal 1, parser.create_url(url).id
    assert_equal 2, parser.create_url(url1).id
    assert_equal url, first.address
    assert_equal url1, second.address
  end

  def test_create_referrer_table
    parser = Parser.new
    referrer = "http://jumpstartlab.com"
    referrer1 = "http://google.com"

    first = parser.create_referrer(referrer)
    second = parser.create_referrer(referrer1)

    assert_equal 1, parser.create_referrer(referrer).id
    assert_equal 2, parser.create_referrer(referrer1).id
    assert_equal "http://jumpstartlab.com", first.address
    assert_equal "http://google.com", second.address
  end

  def test_create_request_table
    parser = Parser.new
    request ="GET"
    request1 = "POST"

    first = parser.create_request(request)
    second = parser.create_request(request1)

    assert_equal 1, parser.create_request(request).id
    assert_equal 2, parser.create_request(request1).id
    assert_equal "GET", first.verb
    assert_equal "POST", second.verb
  end

  def test_create_event_table
    parser = Parser.new
    event = "socialLogin"
    event1 = "antisocialLogin"

    first = parser.create_event(event)
    second = parser.create_event(event1)

    assert_equal 1, parser.create_event(event).id
    assert_equal 2, parser.create_event(event1).id
    assert_equal "socialLogin", first.name
    assert_equal "antisocialLogin", second.name
  end

  def test_create_user_agent_table
    parser = Parser.new
    user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"
    user_agent2 = "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.4; en-US; rv:1.9.2.2) Gecko/20100316 Firefox/3.6.2"

    first = parser.create_user_agent(user_agent)
    second = parser.create_user_agent(user_agent2)

    assert_equal 1, first.id
    assert_equal 2, second.id
    assert_equal "Chrome", first.browser
    assert_equal "Macintosh", first.platform
    assert_equal "Firefox", second.browser
    assert_equal "Macintosh", second.platform
  end

  def test_create_resolution_table
    parser = Parser.new
    hash = {
            :url=>"http://jumpstartlab.com/blog",
            :requestedAt=>"2013-02-16 21:38:28 -0700",
            :respondedIn=>37,
            :referredBy=>"http://jumpstartlab.com",
            :requestType=>"GET",
            :parameters=>[],
            :eventName=>"socialLogin", :userAgent=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
            :resolutionWidth=>"1920", :resolutionHeight=>"1280",
            :ip=>"63.29.38.211"
          }
    hash1 = {
              :url=>"http://jumpstartlab.com/blog",
              :requestedAt=>"2013-02-16 21:38:28 -0700",
              :respondedIn=>37,
              :referredBy=>"http://jumpstartlab.com",
              :requestType=>"GET", :parameters=>[],
              :eventName=>"socialLogin", :userAgent=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
              :resolutionWidth=>"1800", :resolutionHeight=>"1200",
              :ip=>"63.29.38.211"
            }
    res = parser.create_resolution(hash)
    res2 = parser.create_resolution(hash1)

    assert_equal 1, res.id
    assert_equal 2, res2.id
    assert_equal "1280", res.height
    assert_equal "1920", res.width
    assert_equal "1200", res2.height
    assert_equal "1800", res2.width
  end

  def test_create_ip_table
    parser = Parser.new
    ip_one = "63.29.38.211"
    ip_two = "62.24.33.211"

    ip1 = parser.create_ip(ip_one)
    ip2 = parser.create_ip(ip_two)

    assert_equal 1, ip1.id
    assert_equal 2, ip2.id
    assert_equal ip_one, ip1.address
    assert_equal ip_two, ip2.address
  end

  def test_parse_entire_payload_and_create_payload_request_table
    parser = Parser.new
    Client.create(identifier: "google.com", root_url: "www.google.com")
    parsed = parser.parse_payload(@string, "google.com" )

    assert_equal "2013-02-16 21:38:28 -0700", parsed.requested_at
    assert_equal  37, parsed.responded_in
    assert_equal "[]", parsed.parameters
    assert_equal 1, parsed.url.id
    assert_equal 1, parsed.referrer.id
    assert_equal 1, parsed.request.id
    assert_equal 1, parsed.user_agent_b.id
    assert_equal 1, parsed.resolution.id
    assert_equal 1, parsed.ip.id
    assert_equal 1, parsed.client_id
    assert parsed.key
  end

end
