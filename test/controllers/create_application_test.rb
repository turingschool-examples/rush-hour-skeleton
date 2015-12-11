require_relative '../test_helper'

class CreateApplicationTest < Minitest::Test
  def test_it_creates_application_with_valid_attributes
    post '/sources', JSON.parse('{"identifier": "jumpstartlab", "rootUrl": "http://jumpstartlab.com"}')

    assert_equal 200, last_response.status
    assert_equal 1, Application.count
    assert_equal "Application created. {\"identifier\":\"jumpstartlab\"}", last_response.body
  end

  def test_application_is_not_created_with_missing_idenfifier
    post '/sources', JSON.parse('{"rootUrl":"http://jumpstartlab.com"}')

    assert_equal 400, last_response.status
    assert_equal 0, Application.count
    assert_equal "Missing identifier.", last_response.body
  end

  def test_application_is_not_created_with_missing_root_url
    post '/sources', JSON.parse('{"identifier": "jumpstartlab"}')

    assert_equal 400, last_response.status
    assert_equal 0, Application.count
    assert_equal "Missing rootUrl.", last_response.body
  end

  def test_application_is_not_created_with_exiting_identifier
    Application.create(identifier: 'jumpstartlab', root_url: "http://jumpstartlab.com")
    post '/sources', JSON.parse('{"identifier": "jumpstartlab", "rootUrl": "http://jumpstartlab.com"}')

    assert_equal 403, last_response.status
    assert_equal 1, Application.count
    assert_equal "Identifier already exists.", last_response.body
  end
end
