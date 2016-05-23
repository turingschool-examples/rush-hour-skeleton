require_relative '../test_helper'
class RushHourAppTest < Minitest::Test
  include TestHelpers

  def setup
    @data = 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
  end

  def test_the_application_can_create_a_client
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    assert_equal 200, last_response.status
    assert_equal "Client creation successful!", last_response.body
    assert_equal 1, Client.count
  end

  def test_the_application_errors_403_if_client_already_exists
    post '/sources',  {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    post '/sources',  {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    assert_equal 403, last_response.status
    assert_equal "Client already exists.", last_response.body
    assert_equal 1, Client.count
  end

  def test_the_application_errors_400_if_client_is_invalid
    post '/sources', {rootUrl: "http://jumpstartlab.com"}

    assert_equal 400, last_response.status
    assert_equal "Client identifier or root url not provided.", last_response.body
    assert_equal 0, Client.count
  end

  def test_the_application_passes_200_when_new_payload_is_created
    post '/sources', {identifier: "jumpstartlab", rootUrl:"http://jumpstartlab.com"}
    post '/sources/jumpstartlab/data', @data

    assert_equal 200, last_response.status
    assert_equal "OK", last_response.body
    assert_equal 1, Client.count
    assert_equal 1, PayloadRequest.count
  end

  def test_the_application_errors_403_when_client_does_not_exist
    post '/sources', {identifier: "jumpstartlab", rootUrl:"http://jumpstartlab.com"}
    post '/sources/nytimes/data', @data

    assert_equal 403, last_response.status
    assert_equal "Url does not exist", last_response.body
    assert_equal 1, Client.count
    assert_equal 0, PayloadRequest.count
  end

  def test_the_application_errors_400_when_payload_is_not_valid
    post '/sources', {identifier: "jumpstartlab", rootUrl:"http://jumpstartlab.com"}
    post '/sources/jumpstartlab/data', "payload={}"

    assert_equal 400, last_response.status
    assert_equal "Payload is missing", last_response.body
    assert_equal 1, Client.count
    assert_equal 0, PayloadRequest.count
  end

  def test_the_application_errors_400_when_no_payload_is_given
    post '/sources', {identifier: "jumpstartlab", rootUrl:"http://jumpstartlab.com"}
    post '/sources/jumpstartlab/data', @data
    post '/sources/jumpstartlab/data', @data

    assert_equal 403, last_response.status
    assert_equal "Payload already received", last_response.body
    assert_equal 1, Client.count
    assert_equal 1, PayloadRequest.count
  end

end
