require "./test/test_helper"

class CreateSourceTest < MiniTest::Test
  include Rack::Test::Methods

  attr_reader :source

  def setup
  @source    =  { identifier: "jumpstartlab",
                  root_url: "http://jumpstartlab.com" }

  end

  def create_url
    Url.create(address: "http://jumpstartlab.com/blog")
  end

  def app
    TrafficSpy::Server
  end

  def teardown
    DatabaseCleaner.clean
  end

  def register_app
    Source.create(source)
  end

  def data_setup
    register_app
    post "/sources/jumpstartlab/data",
          'payload={"url":"http://jumpstartlab.com/blog",
          "requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,
          "referredBy":"http://jumpstartlab.com","requestType":"GET",
          "parameters":[],"eventName": "socialLogin",
          "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2)
           AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0
           Safari/537.17","resolutionWidth":"1920",
           "resolutionHeight":"1280","ip":"63.29.38.211"}'
    post "/sources/jumpstartlab/data",
          'payload={"url":"http://jumpstartlab.com/blog",
          "requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":40,
          "referredBy":"http://jumpstartlab.com","requestType":"POST",
          "parameters":[],"eventName": "socialLogin",
          "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2)
           AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0
           Safari/537.17","resolutionWidth":"1920",
           "resolutionHeight":"1280","ip":"63.29.38.211"}'
  end

  def test_the_correct_url_is_created
    url = Url.create_url(source[:root_url], "blog")
    assert_equal "http://jumpstartlab.com/blog", url
  end

  def test_when_the__url_does_not_exist_return_error
    register_app
    get "/sources/jumpstartlab/urls/kyra"
    assert_equal 404, last_response.status
  end

  def test_can_find_response_times
    data_setup
    get "/sources/jumpstartlab/urls/blog"
    assert_equal 40, Url.longest_response("http://jumpstartlab.com/blog")
    assert_equal 37, Url.shortest_response("http://jumpstartlab.com/blog")
    assert_equal 38, Url.average_response("http://jumpstartlab.com/blog")
  end

  def test_can_find_http_verbs
    data_setup
    RequestType.create(http_verb: "GET")
    RequestType.create(http_verb: "POST")
    RequestType.create(http_verb: "POST")
    get "/sources/jumpstartlab/urls/blog"
    assert_equal ["GET", "POST"], Url.http_verbs("http://jumpstartlab.com/blog")
  end

  def test_can_find_popular_referrer
    data_setup
    post "/sources/jumpstartlab/data", 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://facebook.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    get "/sources/jumpstartlab/urls/blog"
    assert_equal "http://jumpstartlab.com", Url.popular_referrer("http://jumpstartlab.com/blog")
  end

  def test_can_find_most_popular_user_agent
    data_setup
    PayloadUserAgent.create(browser: "Chrome", os: "Macintosh")
    PayloadUserAgent.create(browser: "Firefox", os: "Microsoft")
    PayloadUserAgent.create(browser: "Chrome", os: "Macintosh")
    get "/sources/jumpstartlab/urls/blog"
    assert_equal ["Chrome", "Macintosh"], Url.popular_user_agent("http://jumpstartlab.com/blog")
  end


end
