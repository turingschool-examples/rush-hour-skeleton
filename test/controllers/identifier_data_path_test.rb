require_relative '../test_helper'

class IdentifierDataPathTest < ControllerTest

  def test_registration_returns_403_when_identifier_not_registered
    post '/sources/identifier_not_in_database/data', 'who cares'

    assert_equal 403, last_response.status
    assert_equal 'Application Not Registered - 403 Forbidden', last_response.body
  end

  def test_if_the_payload_is_missing
    post '/sources', { "identifier" => "facebook", "rootUrl" => "http://facebook.com" }
    id = Registration.all.first.identifier
    post "/sources/#{id}/data", nil

    assert_equal 400, last_response.status
    assert_equal "Missing Payload - 400 Bad Request", last_response.body
  end

  def test_url_is_saved
    post '/sources', { "identifier" => "facebook", "rootUrl" => "http://facebook.com" }
    id = Registration.all.first.identifier

    post "/sources/#{id}/data", {payload: {"url":"http://google.com/about"}}

    assert_equal "http://google.com/about", Url.all.first.url
  end

  def test_if_the_payload_has_already_been_recieved
    skip
    post '/sources', { "identifier" => "facebook", "rootUrl" => "http://facebook.com" }
    id = Registration.all.first.identifier
   payload =  {payload: {"url":"http://google.com/about","requestedAt":"2013-01-16 21:38:28 -0700","respondedIn":90,      "referredBy":"http://apple.com","requestType":"POST","parameters":["what","huh"],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1080","ip":"63.29.38.213"}}

    post "/sources/#{id}/data", payload
    post "/sources/#{id}/data", payload

    assert_equal 403, last_response.status
    assert_equal "Already Received Request - 403 Forbidden", last_response.body
  end
end
