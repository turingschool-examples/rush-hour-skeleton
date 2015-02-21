require "./test/test_helper"

class CreateSourceTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_the_correct_url_is_created
    get '/sources/jumpstart/urls/blog'
    assert

  end

end
