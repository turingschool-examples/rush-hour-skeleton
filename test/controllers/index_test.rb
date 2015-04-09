require './test/test_helper'

class IndexTest < Minitest::Test
  include Rack::Test::Methods

  def app
    # Server
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_it_shows_the_index
    get '/'
    assert_equal 200, last_response.status
  end
  
end