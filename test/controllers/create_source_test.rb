require_relative '../test_helper'

class CreateSourceTest < Minitest::Test
  include Rack::Test::Methods     # allows us to use get, post, last_request, etc.

  def app     # def app is something that Rack::Test is looking for
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_can_create_source_with_identifier_and_root_url
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
  end

end
#   As a user
#   When I send a POST request to  http://yourapplication:port/sources with the parameters 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
#   Then I expect a 200 response with data as JSON {"identifier":"jumpstartlab"}
#
#   As a user
#   When I send a POST request to  http://yourapplication:port/sources with the parameters 'rootUrl=http://jumpstartlab.com'
#   Then I expect a 400 response with data as "Please provide an identifier"
#
#   As a user
#   When I send a POST request to  http://yourapplication:port/sources with the parameters 'identifier=jumpstartlab'
#   Then I expect a 400 response with data as "Please provide a url"
#
#   As a user
#   When I send a POST request to  http://yourapplication:port/sources with the parameters ''identifier=jumpstartlab&rootUrl=http://jumpstartlab.com' and it already exists
# Then I expect a 403 response with data as "identifier and url already exist"

#
#
# class CreateTaskTest < Minitest::Test
#   include Rack::Test::Methods     # allows us to use get, post, last_request, etc.
#
#   def app     # def app is something that Rack::Test is looking for
#     TaskManager
#   end
#
#   def setup
#     DatabaseCleaner.start
#   end
#
#   def teardown
#     DatabaseCleaner.clean
#   end
#
#   def test_create_a_task_with_title_and_description
#     initial_count = Task.count
#     post '/tasks', { task: { title: "something", description: "else" } }
#     final_count = Task.count
#     assert_equal 200, last_response.status
#     assert_equal "Your task was just created!", last_response.body
#     assert_equal 1, (final_count - initial_count)
#   end
#
#   def test_returns_error_when_missing_title
#     initial_count = Task.count
#     post '/tasks', { task: { description: "blah blah blah"}}
#     final_count = Task.count
#     assert_equal 403, last_response.status
#     assert_equal "missing title ya bozo", last_response.body
#     assert_equal final_count, initial_count
#   end
# end
