require_relative '../test_helper'

class ServerPayloadTest < TrafficTest
  include PayloadPrep

  def test_payload_table_loads_valid_data
    register_user_thru_controller
    first_count = TrafficSpy::Payload.count
    post '/sources/jumpstartlab/data', payload_params1
    second_count = TrafficSpy::Payload.count

    assert_equal 200, last_response.status
    assert_equal 1, (second_count - first_count)
  end

  def test_duplicate_payload_is_rejected
    register_user_thru_controller
    post '/sources/jumpstartlab/data', payload_params1
    post '/sources/jumpstartlab/data', payload_params1
    response = "This specific payload already exists in the database..."

    assert_equal 403, last_response.status
    assert_equal response, last_response.body
  end

  def test_missing_payload_is_rejected
    register_user_thru_controller
    post '/sources/jumpstartlab/data'
    response = "No payload received in the request"

    assert_equal 400, last_response.status
    assert_equal response, last_response.body
  end

  def test_unregistered_user_cannot_submit_payload
    post '/sources/jumpstartlab/data', payload_params1
    response = "jumpstartlab is not registered"

    assert_equal 403, last_response.status
    assert_equal response, last_response.body
  end

end
