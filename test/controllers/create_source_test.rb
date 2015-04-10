require './test/test_helper'
require 'byebug'

class CreateSourceTest < ControllerTest
  def app 
    TrafficSpy::Server
  end

  def test_create_source_with_an_identifier_and_root_url
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    source = TrafficSpy::Source.first

    assert_equal "jumpstartlab", source.identifier
    assert_equal 1, TrafficSpy::Source.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
  end 

  def test_create_it_cannot_create_source_without_identifier
    source_count = TrafficSpy::Source.count
    post '/sources', 'rootUrl=http://jumpstartlab.com'

    assert_equal source_count, TrafficSpy::Source.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end 

  def test_create_it_cannot_create_source_without_root_url
    source_count = TrafficSpy::Source.count
    post '/sources', 'identifier=jumpstartlab'

    assert_equal source_count, TrafficSpy::Source.count
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end 

  def test_it_returns_error_when_identifier_already_exists
    # post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    TrafficSpy::Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    assert_equal "jumpstartlab", TrafficSpy::Source.first.identifier

    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    assert_equal 403, last_response.status
    assert_equal "Identifier already exists", last_response.body
  end

end