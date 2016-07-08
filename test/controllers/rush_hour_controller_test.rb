require_relative '../test_helper'

class RushHourTest < Minitest::Test
  include TestHelpers

  def test_that_it_creates_a_client_with_a_unique_identifier_and_a_root_url
    post '/sources', { client: {identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com'}}

    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "Sucess", last_response.body
  end

  def test_that_it_cannot_create_client_without_identifier
    post '/sources', { client: {root_url: 'http://jumpstartlab.com'}}

    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_that_it_cannot_create_client_without_root_url
    post '/sources', { client: {identifier: 'jumpstartlab'}}

    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end

  def test_it_does_not_create_client_with_existing_identifier
    post '/sources', { client: {identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com'}}
    post '/sources', { client: {identifier: 'jumpstartlab', root_url: 'http://jumpstartlab.com'}}

    assert_equal 403, last_response.status
    assert_equal "Identifier Already Exists", last_response.body
  end


end
