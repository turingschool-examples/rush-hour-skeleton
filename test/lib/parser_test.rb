require_relative '../test_helper'

class ParserTest < Minitest::Test
  def test_it_exists
    assert Parser
  end

  def test_it_handles_empty_params
    parser  = Parser.new({})

    refute parser.request_hash
    refute parser.id
    refute parser.application_id
    refute parser.url
    refute parser.url_id
    refute parser.timestamp
    refute parser.response_time
    refute parser.referral
    refute parser.verb
    refute parser.event
    refute parser.event_id
    refute parser.browser
    refute parser.os
    refute parser.resolution

  end

  def test_it_creates_request_hash_for_valid_resquests
    parser = Parser.new(params)
    assert_equal "582782a967bdfb675f1c3445ded79782ae109f5a", parser.request_hash
  end

  def test_it_parsers_valid_url
    parser = Parser.new(params)
    assert_equal "blog", parser.url
  end

  def test_it_parsers_valid_url_id
    Url.create(path: 'blog')
    parser = Parser.new(params)
    assert_equal 1, parser.url_id
  end

  def test_it_parsers_valid_timestamp
    parser = Parser.new(params)
    assert_equal "2013-02-16 21:38:28 -0700", parser.timestamp
  end

  def test_it_parsers_valid_response_time
    parser = Parser.new(params)
    assert_equal 37, parser.response_time
  end

  def test_it_parsers_valid_referral
    parser = Parser.new(params)
    assert_equal "http://jumpstartlab.com", parser.referral
  end

  def test_it_parsers_valid_verb
    parser = Parser.new(params)
    assert_equal 'GET', parser.verb
  end

  def test_it_parsers_valid_event
    parser = Parser.new(params)
    assert_equal 'socialLogin', parser.event
  end

  def test_it_parsers_valid_event_id
    Event.create(name: 'socialLogin')
    parser = Parser.new(params)
    assert_equal 1, parser.event_id
  end

  def test_it_parsers_valid_browser
    parser = Parser.new(params)
    assert_equal 'Chrome 24.0.1309', parser.browser
  end

  def test_it_parsers_valid_os
    parser = Parser.new(params)
    assert_equal 'Mac OS X 10.8.2', parser.os
  end

  def test_it_parsers_valid_resolution
    parser = Parser.new(params)
    assert_equal '1920x1280', parser.resolution
  end

  def test_it_prepares_request_data
    Event.create(name: 'socialLogin')
    Url.create(path: 'blog')
    Application.create(identifier: 'jumpstartlab', root_url: "http://jumpstartlab.com")

    parser = Parser.new(params)
    expected = {  :request_hash => '582782a967bdfb675f1c3445ded79782ae109f5a',
                  :application_id => 1,
                  :url_id => 1,
                  :timestamp => '2013-02-16 21:38:28 -0700',
                  :response_time => 37,
                  :referral => 'http://jumpstartlab.com',
                  :verb => 'GET',
                  :event_id => 1,
                  :browser => 'Chrome 24.0.1309',
                  :os => 'Mac OS X 10.8.2',
                  :resolution => '1920x1280'
                }
    assert_equal expected, parser.request_data
  end

  def params
    {"payload"=>"{
      \"url\":\"http://jumpstartlab.com/blog\",
      \"requestedAt\":\"2013-02-16 21:38:28 -0700\",
      \"respondedIn\":37,
      \"referredBy\":\"http://jumpstartlab.com\",
      \"requestType\":\"GET\",
      \"parameters\":[],
      \"eventName\": \"socialLogin\",
      \"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",
      \"resolutionWidth\":\"1920\",
      \"resolutionHeight\":\"1280\",
      \"ip\":\"63.29.38.211\"}",
 "splat"=>[],
 "captures"=>["jumpstartlab"],
 "id"=>"jumpstartlab"}
  end
end
