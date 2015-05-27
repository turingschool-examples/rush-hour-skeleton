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

  def test_it_runs
    assert_equal 2, 1+1
  end

  def test_it_posts_to_sources_with_valid_data
    post "/sources", {source: {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"} }
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
  end

 #  def test_register_a_source_with_an_identifier_and_root_url
 #   post '/sources', { source: { identifier: "something", rootUrl: "else"} }
 #  #  assert_equal 1, Source.count
 #   assert_equal 200, last_response.status
 #  #  assert_equal "created!", last_response.body
 # end
end


# As a user:
# When I send a POST request to
# http://yourapplication:port/sources
# with the paramaters:
# 'identifier=jumpstartlab and rootUrl=http://jumpstartlab.com'
# Then I expect a 200 response with the data as JSON {"identifier":"jumpstartlab"}
#


# As a user:
# When I send a POST request to
# http://yourapplication:port/sources
# with the paramaters:
# 'rootUrl=http://jumpstartlab.com'
# Then I expect a 400 response with a descriptive error message
