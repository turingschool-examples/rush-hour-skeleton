require "./test/test_helper"

class CreateSourceTest < MiniTest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_create_source_with_correct_parameters
    post "/sources", { identifier: "some identifier",
                       root_url: "some root_url" }
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"some identifier\"}", last_response.body
    assert_equal 1, Source.count
  end

  def test_invalidates_source_with_missing_parameters
    post "/sources", { root_url: "some root_url" }
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
    assert_equal 0, Source.count
  end

  def test_invalidates_source_when_identifier_not_unique
    post "/sources", { identifier: "some identifier",
                       root_url: "some root_url" }
    assert_equal 1, Source.count
    assert_equal 200, last_response.status
    post "/sources", { identifier: "some identifier",
                       root_url: "some root_url" }
    assert_equal 403, last_response.status
    assert_equal "Identifier has already been taken", last_response.body
    assert_equal 1, Source.count
  end
end
