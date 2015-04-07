require './test/test_helper'
require 'byebug'
require 'json'

class CreateSourceTest < Minitest::Test
  include Rack::Test::Methods

  def app 
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  # def test_it_parses_json
  #   skip
  # end

  def test_create_source_with_an_identifier_and_root_url
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    source = Source.first

    assert_equal "jumpstartlab", source.identifier
    assert_equal 1, Source.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
  end 

  def test_create_it_cannot_create_source_without_identifier
    source_count = Source.count
    post '/sources', 'rootUrl=http://jumpstartlab.com'

    assert_equal source_count, Source.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end 

  def test_create_it_cannot_create_source_without_root_url
    source_count = Source.count
    post '/sources', 'identifier=jumpstartlab'

    assert_equal source_count, Source.count
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end 

  def test_it_returns_error_when_identifier_already_exists
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    assert_equal "jumpstartlab", Source.first.identifier

    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    assert_equal 403, last_response.status
    assert_equal "Identifier already exists", last_response.body
  end

end