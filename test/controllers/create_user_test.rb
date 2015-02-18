require './test/test_helper'

class CreateUserTest < Minitest::Test
  include Rack::Test::Methods     # allows us to use get, post, last_response, etc.

  def app     # def app is something that Rack::Test is looking for
    TrafficSpy::Server
  end

  def teardown
    DatabaseCleaner.clean
  end


  def test_it_creates_user
  	post '/sources', { sources: { identifier: 'jumpstartlab',
  		                            rootUrl: 'http://jumpstartlab.com'}}
    assert_equal 1, User.count
    assert_equal 200, last_response.status
    assert_equal 'success', last_response.body
  end

end