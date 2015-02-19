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
    post '/sources', {identifier: 'jumpstartlab',
                      rootUrl: 'jumpstartlab.com' }
    assert_equal 200, last_response.status
    assert_equal 1, Identifier.count
    assert_equal '{"identifier":"jumpstartlab"}', last_response.body
  end

  def test_it_does_not_accept_without_validation
    message = "400 Bad Request\nName can't be blank Root url can't be blank"
    post '/sources', {}
    assert_equal 400, last_response.status
    assert_equal 0, Identifier.count
    assert_equal message, last_response.body
  end

  def test_it_does_not_allow_duplicate_identifier
    message = "403 Forbidden\nName has already been taken"
    attributes = {identifier: 'jumpstartlab',
                  rootUrl: 'jumpstartlab.com' }
    Identifier.create(name: 'jumpstartlab', root_url: 'jumpstartlab.com')
    post '/sources', attributes
    assert_equal 403, last_response.status
    assert_equal message, last_response.body
  end

  def test_it_posts_to_url_with_specific_identifier
    Identifier.create(name: 'jumpstartlab', root_url: 'jumpstartlab.com')
    post '/sources/jumpstartlab/data'
    assert_equal 200, last_response.status
  end

  def test_it_gives_error_if_missing_identifier
    post '/sources/jumpstartlab/data'
    assert_equal 400, last_response.status
  end

  def test_identify_the_payload


  end


end
