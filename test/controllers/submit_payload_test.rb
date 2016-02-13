require_relative '../test_helper'

class SubmitPayloadTest <Minitest::Test
  include TestHelpers
  include Rack::Test::Methods

  def test_submitted_payload_stored_in_database
    client_setup
    payload_setup1
    payload = Payload.last

    assert_equal 1, Payload.count

    assert_equal "jumpstartlab", payload.client.identifier
    assert_equal 37, payload.response_time
    assert_equal "GET", payload.request_type.verb
    assert_equal "http://jumpstartlab.com", payload.refer.address
    assert_equal "socialLogin", payload.event.name
    assert_equal "Chrome", payload.user_environment.browser
    assert_equal "OS X 10.8.2", payload.user_environment.os
    assert_equal "1920", payload.resolution.width
    assert_equal "1280", payload.resolution.height
    assert_equal "63.29.38.211", payload.ip.address
    assert_equal "http://jumpstartlab.com/blog", payload.url.address


    # payload_setup2
    # assert_equal 2, Payload.count
    # assert_equal "turing", Payload.last.client.identifier
  end

  def test_valid_payload_post_returns_200_and_message
    skip
    payload_setup1
    assert_equal 1, Payload.count
    assert_equal 200, last_response.status
  end

  def test_missing_payload_post_returns_400_and_message
    skip
    post '/sources/jumpstartlab/'
    assert_equal 0, Payload.count
    assert_equal 400, last_response.status
    assert_equal "Please submit a payload.", last_response.body
  end

  def test_duplicate_payload_post_returns_403_and_message
    skip
    payload_setup1
    assert_equal 1, Payload.count
    assert_equal 200, last_response.status

    payload_setup1
    assert_equal 1, Payload.count
    assert_equal "You have already submitted this payload.", last_response.body
    assert_equal 403, last_response.status
  end

  def test_URL_that_doesnt_exist_in_database_returns_403_and_message
    skip
    payload_setup3
    assert_equal 0, Payload.count
    assert_equal 403, last_response.status
    assert_equal "You can only track URLs that belong to you.", last_response.body
  end
end
