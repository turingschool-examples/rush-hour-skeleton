require './test/test_helper'

class ServerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_create_registration_with_parameter
    post '/sources' ,{identifier: {title: "jumpstartlab", root_url: "http://jumpstartlab.com" }}
    t = Identifier.last
    assert_equal 200, last_response.status
    assert_equal "success", last_response.body
  end
end
