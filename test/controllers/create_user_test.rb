require './test/test_helper'

class CreateUserTest < Minitest::Test
  include Rack::Test::Methods     # allows us to use get, post, last_response, etc.

  def app     # def app is something that Rack::Test is looking for
    TrafficSpy
  end

  def teardown
    DatabaseCleaner.clean
  end


  def test_it_creates_user
  	skip
  	post '/sources', { sources: { identifier: 'jumpstartlab',
  		                            rootUrl: 'http://jumpstartlab.com'}}
  end

end