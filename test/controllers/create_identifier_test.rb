require './test/test_helper.rb'

class CreateIdentifierTest < Minitest::Test
  include Rack::Test::Methods     # allows us to use get, post, last_request, etc.

  def app     # def app is something that Rack::Test is looking for
    TrafficSpy::Server
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_it_creates_an_identifier_with_correct_parameters
    post '/sources',{name: 'jumpstartlab',
                     root_url: 'jumpstartlab.com' }
    assert_equal 200, last_response.status
    assert_equal 1, Identifier.count
    assert_equal "created", last_response.body
  end

  def test_it_does_not_accept_without_validation
    post '/sources', {}
    assert_equal 400, last_response.status
    assert_equal 0, Identifier.count
    assert_equal "Name can't be blank\nRoot url can't be blank", last_response.body
  end
end
