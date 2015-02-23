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
  	post '/sources', { sources: { 'identifier' => 'jumpstartlab',
  		                            'rootUrl'    => 'http://jumpstartlab.com'}}
    assert_equal 1, User.count
    assert_equal 200, last_response.status
    assert_equal 'success', last_response.body
  end

  def test_it_assigns_user_attributes
    post '/sources', { sources: { 'identifier' => 'jumpstartlab',
                                  'rootUrl'    => 'http://jumpstartlab.com'}}
    user = User.last
    assert_equal 'jumpstartlab', user.identifier
    assert_equal 'http://jumpstartlab.com', user.rootUrl
    assert_equal 1, user.id
  end

  def test_it_raises_error_when_missing_attribute
    post '/sources', { sources: { 'identifier' => 'jumpstartlab'}}
    assert_equal 400, last_response.status
    assert_equal "Rooturl can't be blank", last_response.body
  end

end