require './test/test_helper'

class CreatesSourceTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def test_creates_source_with_identifier_and_url
    post '/sources', {"identifier" => "stanley", "rootUrl" => "http://www.abc.com"}


    assert_equal 1, Source.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\": \"stanley\"}", last_response.body
  end

  def test_400_error_bad_request
    post '/sources', {"rootUrl" => "http://www.abc.com"}
    assert_equal 400, last_response.status
    assert_equal "Missing Parameters", last_response.body
  end

  def test_validates_uniqueness
    post '/sources', {"identifier" => "stanley", "rootUrl" => "http://www.abc.com"}
    assert_equal 1, Source.count
    assert_equal 200, last_response.status
    post '/sources', {"identifier" => "stanley", "rootUrl" => "http://www.abc.com"}
    assert_equal 1, Source.count
    assert_equal 403, last_response.status
  end


  def teardown
    DatabaseCleaner.clean
  end

end
