require_relative '../test_helper'

class ServerAppTest < Minitest::Test
  include TestHelpers

  def test_the_application_can_create_a_client
    post '/sources', {identifier: "turing", rootUrl: "https://turing.io"}
    assert_equal "Client created", last_response.body
    assert_equal 1, Client.count
    assert_equal 200, last_response.status
  end

  def test_the_application_cannot_create_a_client_without_an_identifier
    post '/sources', {rootUrl: "https://google.com"}
    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_the_application_cannot_create_a_client_without_a_root_url
    post '/sources', {identifier: "google"}
    assert_equal 0, Client.count
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end

  def test_client_receives_error_if_client_identifier_is_taken
    post '/sources', {identifier: "turing", rootUrl: "https://turing.io"}
    post '/sources', {identifier: "turing", rootUrl: "https://turing.io"}
    assert_equal 403, last_response.status
    assert_equal "Identifier has already been taken", last_response.body
    assert_equal 1, Client.count
  end

  def test_the_application_can_create_a_payload
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2015-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    assert_equal 200, last_response.status
    assert_equal 1, PayloadRequest.count
    assert_equal "Payload received", last_response.body
  end

  def test_the_application_cannot_create_a_payload_without_params
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    post '/sources/jumpstartlab/data'

    assert_equal 400, last_response.status
    assert_equal "Payload cannot be blank", last_response.body
  end

  def test_payload_request_cannot_be_processed_without_client
    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    assert_equal 403, last_response.status
    assert_equal 0, PayloadRequest.count
    assert_equal "Application has not been registered", last_response.body
  end

  def test_the_application_cannot_create_a_duplicate_payload
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 1, PayloadRequest.count

    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 403, last_response.status
    assert_equal 1, PayloadRequest.count
    assert_equal "Payload has already been received", last_response.body
  end

  def test_that_client_can_get_their_page
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    post '/sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    get 'sources/jumpstartlab'
    assert_equal 200, last_response.status
    assert last_response.body.include?("Data")
  end
end
