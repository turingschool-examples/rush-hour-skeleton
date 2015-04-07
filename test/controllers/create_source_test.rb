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

  def test_create_source_with_an_identifier_and_rootURL
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    #post '/sources', "{\"identifier\":\"jumpstartlabs\",\"rootURL\":\"http://www.jumpstartlabs.com\"}"
    #post '/sources', { "identifier" => "jumpstartlabs", "rootURL" => "http://www.jumpstartlabs.com" }.to_json
    source = Source.first

    assert_equal "jumpstartlab", source.identifier
    assert_equal 1, Source.count
    assert_equal 200, last_response.status
    assert_equal "success", last_response.body
  end 

end