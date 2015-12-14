require_relative '../test_helper'

class HelpersTest < TrafficTest
  include PayloadPrep

  class FakeHelpers
    include Helpers
    include PayloadPrep

    attr_reader :user
    def initialize
      register_user
      payload_parser = TrafficSpy::PayloadParser.new({"payload"=>
        "{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}",
       "splat"=>[],
       "captures"=>["jumpstartlab"],
       "id"=>"jumpstartlab"})
      payload_parser.payload_response
      @user = TrafficSpy::User.find(1)
    end

  end

  def setup
    @helper = FakeHelpers.new
  end

  def test_returns_full_linked_path
    expected = '/sources/jumpstartlab/urls/news'
    assert_equal expected, @helper.url_path("http://jumpstartlab/news")
  end

  def test_returns_event_path
    expected = '/sources/jumpstartlab/events/socialLogin'
    assert_equal expected, @helper.event_path("socialLogin")
  end

  def test_returns_relative_path
    expected = "news"
    assert_equal expected, @helper.relative_path('http://jumpstartlab.com/news')
  end

  def test_returns_full_path
    assert_equal "http://jumpstartlab.com/news", @helper.full_path('news')
  end

end
