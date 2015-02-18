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


  def teardown
    DatabaseCleaner.clean
  end

end
