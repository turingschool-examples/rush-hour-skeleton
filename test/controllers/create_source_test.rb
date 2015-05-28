require_relative '../test_helper'

class CreateSourceTest < ControllerTest

  def test_can_create_source_with_identifier_and_root_url
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
  end

  def test_can_give_400_response_when_identifier_is_missing
    post '/sources' , { "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 400, last_response.status
    assert_equal "missing a parameter ya doofus", last_response.body
  end

  def test_can_give_400_response_when_root_url_is_missing
    post '/sources' , { "identifier" => "jumpstartlab" }
    assert_equal 400, last_response.status
    assert_equal "missing a parameter ya doofus", last_response.body
  end

  def test_can_give_a_403_status_when_identifier_already_exists
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
    post '/sources' , { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 403, last_response.status
    assert_equal "identifier already exists", last_response.body
  end

end

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
