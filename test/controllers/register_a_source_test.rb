require './test/test_helper'

class RegisterSourceTest < Minitest::Test
  include Rack::Test::Methods     # allows us to use get, post, last_request, etc.

  def app     # def app is something that Rack::Test is looking for
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start #move these two methods to test helper
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_register_a_source_with_an_identifier_and_root_url
   post '/sources', { source: { identifier: "something", rootURL: "else"} }
  #  assert_equal 1, Source.count
   assert_equal 200, last_response.status
  #  assert_equal "created!", last_response.body
 end
end
