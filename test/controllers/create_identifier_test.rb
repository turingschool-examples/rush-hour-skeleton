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
    post '/sources', {source: {name: 'jumpstartlab',
                               root_url: 'jumpstartlab.com' }}
    assert_equal 200, last_response.status
    assert_equal 1, Identifier.count
    assert_equal "created", last_response.body
  end

end
