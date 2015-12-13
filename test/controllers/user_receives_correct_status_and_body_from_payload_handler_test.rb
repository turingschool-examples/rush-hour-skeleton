require_relative '../test_helper'

# add test for empty payload in addition to nil Payload


class UserReceivesCorrectStatusAndBodyFromPayloadHandlerTest < Minitest::Test

  def setup
    Client.create({"name" => "jumpstartlab", "root_url" => "http://jumpstartlab.com"})
  end

  def test_user_receives_200_http_status_with_valid_payload
    post '/sources/jumpstartlab/data', payload

    assert_equal 200, last_response.status
  end

  def test_user_receives_400_http_status_with_missing_payload
    post '/sources/jumpstartlab/data', nil_payload

    assert_equal 400, last_response.status
    assert_equal "Payload Missing.", last_response.body
  end

  def test_user_receives_400_http_status_with_missing_payload
    post '/sources/jumpstartlab/data', empty_payload

    assert_equal 400, last_response.status
    assert_equal "Payload Missing.", last_response.body
  end

  def test_user_receives_403_http_status_for_unregistered_application
    post '/sources/binglol/data', payload

    assert_equal 403, last_response.status
    assert_equal "Application Not Registered.", last_response.body
  end

  def test_user_receives_403_http_status_for_duplicate_payload
    post '/sources/jumpstartlab/data', payload
    post '/sources/jumpstartlab/data', payload

    assert_equal 1, Client.count
    assert_equal 403, last_response.status
    assert_equal "Duplicate Payload.", last_response.body
  end

end
