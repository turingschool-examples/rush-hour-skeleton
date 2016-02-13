require_relative '../test_helper'

class SubmitPayloadTest <Minitest::Test
  include TestHelpers
  include Rack::Test::Methods

  def test_submitted_payload_stored_in_database
    payload_setup1
    assert_equal 1, Payload.count
    assert_equal 1, Payload.id.last

    payload_setup2
    assert_equal 2, Payload.count
    assert_equal 2, Payload.id.last
  end

  def test_valid_payload_post_returns_200_and_message
    payload_setup1
    assert_equal 1, Payload.count
    assert_equal 200, last_response.status
  end

  def test_missing_payload_post_returns_400_and_message
    post '/sources/jumpstartlab/'
    assert_equal 0, Payload.count
    assert_equal 400, last_response.status
    assert_equal "Please submit a payload.", last_response.body
  end

  def test_duplicate_payload_post_returns_403_and_message
    payload_setup1
    assert_equal 1, Payload.count
    assert_equal 200, last_response.status

    payload_setup1
    assert_equal 1, Payload.count
    assert_equal "You have already submitted this payload.", last_response.body
    assert_equal 403, last_response.status
  end

  def test_URL_that_doesnt_exist_in_database_returns_403_and_message
    payload_setup3
    assert_equal 0, Payload.count
    assert_equal 403, last_response.status
    assert_equal "You can only track URLs that belong to you.", last_response.body
  end
end
