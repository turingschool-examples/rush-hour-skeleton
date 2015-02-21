require "./test/test_helper"

class CreateSourceTest < MiniTest::Test
  include Rack::Test::Methods

  attr_reader :source

  def setup
  @source =  { identifier: "jumpstartlab",
                   root_url: "http://jumpstartlab.com" }
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

  def test_the_correct_url_is_created
    url = UrlHelper.create_url(source[:root_url], "blog")
    assert_equal "http://jumpstartlab.com/urls/blog", url
  end

  def test_when_the__url_does_not_exist_return_error
    register_app
    get "/sources/jumpstartlab/urls/kyra"
    assert_equal 404, last_response.status
  end

end
