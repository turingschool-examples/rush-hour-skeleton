require_relative "../test_helper"

class ParserTest < Minitest::Test
  include Parser
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
    @string1 = '{
                "url":"http://jumpstartlab.com/blog",
                "requestedAt":"2013-02-16 21:38:28 -0700",
                "respondedIn":37,
                "referredBy":"http://jumpstartlab.com",
                "requestType":"GET",
                "parameters":[],
                "eventName": "socialLogin",
                "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth":"1950",
                "resolutionHeight":"1200",
                "ip":"63.29.38.211"
              }'

  end

  # def test_it_parses_json
  #   hash = {
  #             "url"=>"http://jumpstartlab.com/blog",
  #             "requestedAt"=>"2013-02-16 21:38:28 -0700",
  #             "respondedIn"=>37,
  #             "referredBy"=>"http://jumpstartlab.com",
  #             "requestType"=>"GET", "parameters"=>[],
  #             "eventName"=>"socialLogin", "userAgent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
  #             "resolutionWidth"=>"1920", "resolutionHeight"=>"1280",
  #             "ip"=>"63.29.38.211"
  #           }
  #   assert_equal hash, json(@string)
  # end
  #
  # def test_it_can_create_resolution_table
  #   resolution_table = parse_resolution(@string)
  #
  #   assert_equal "1280", resolution_table.height
  #   assert_equal "1920", resolution_table.width
  #   assert_equal true, resolution_table.id.integer?
  # end
  #
  # def test_it_can_create_user_agent_table
  #   user_agent_table = parse_user_agent(@string)
  #
  #   assert_equal "Chrome", user_agent_table.browser
  #   assert_equal "24.0.1309.0", user_agent_table.version
  #   assert_equal "Macintosh", user_agent_table.platform
  #   assert_equal true, user_agent_table.id.integer?
  # end

  def test_create_url_table
    url = "http://jumpstartlab.com/blog"
    url1 = "www.google.com"

    create_url(url)
    create_url(url1)

    assert_equal 1, create_url(url).id
  end

  def test_create_referrer_table
    referrer = "http://jumpstartlab.com"
    referrer1 = "http://google.com"

    create_referrer(referrer)
    create_referrer(referrer1)

    assert_equal 1, create_referrer(referrer).id
  end

  def test_create_request_table
    request ="GET"
    request1 = "POST"

    create_request(request)
    create_request(request1)

    assert_equal 1, create_request(request).id
  end

  def test_create_event_table
    event = "socialLogin"
    event1 = "antisocialLogin"

    create_event(event)
    create_event(event1)

    assert_equal 1, create_event(event).id
  end

  def test_create_event_table
    user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"
    user_agent2 = "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.4; en-US; rv:1.9.2.2) Gecko/20100316 Firefox/3.6.2"



    first = create_user_agent(user_agent)
    second = create_user_agent(user_agent2)

    assert_equal 1, first.id
    assert_equal 2, second.id
  end

  def test_create_resolution_table
    res = create_resolution(@string)
    res2 = create_resolution(@string1)

    assert_equal 1, res.id
    assert_equal 2, res2.id
  end

  def test_create_ip_table
    ip_one = "63.29.38.211"
    ip_two = "62.24.33.211"

    ip1 = create_ip(ip_one)
    ip2 = create_ip(ip_two)

    assert_equal 1, ip1.id
    assert_equal 2, ip2.id
  end

end
