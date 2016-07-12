require_relative '../test_helper'

class ServerTest < Minitest::Test
  include TestHelpers

  def test_it_can_take_in_param_and_return_200_status

    params = {"identifier" => "test", "rootUrl" => "http://test.com"}

    post '/sources', params
    assert_equal 200, last_response.status
  end

  def test_it_returns_400_status_if_identifier_is_blank
    params = {"rootUrl" => "http://test.com"}

    post '/sources',  params

    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_it_returns_400_status_if_root_url_is_blank
    params = {"identifier" => "test"}

    post '/sources', params
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end

  def test_it_returns_identifier
    params = {"identifier" => "test", "rootUrl" => "http://test.com"}

    post '/sources', params
    assert_equal 200, last_response.status
    assert_equal "test", last_response.body
  end

  def test_it_returns_403_status_if_identifier_already_exists
    create_payload(1)

    params = {"identifier" => "jumpstartlab0", "rootUrl" => "http://test.com0"}
    post '/sources', params

    assert_equal 403, last_response.status
    assert_equal "Identifier has already been taken", last_response.body
  end

  def test_it_accepts_a_post_to_identifier_data

    client = Client.create(identifier: "test", root_url: "http://test.com")

    payload = '{"url":"http://jumpstartlab.com/blog","parameters":"[]","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    identifier = "test"
    params = {payload: payload, identifier: identifier}
    post '/sources/test/data', params
    assert_equal 200, last_response.status
  end
end
