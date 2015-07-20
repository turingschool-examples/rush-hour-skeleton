require_relative '../test_helper'

class IdentifierDataPathTest < ControllerTest

  def test_registration_returns_403_when_identifier_not_registered
    post '/sources/identifier_not_in_database/data', @raw_payload

    assert_equal 403, last_response.status
    assert_equal 'Application Not Registered - 403 Forbidden', last_response.body
  end

  def test_if_the_payload_is_missing
    post '/sources', { "identifier" => "facebook", "rootUrl" => "http://facebook.com" }
    id = Registration.all.first.identifier
    post "/sources/#{id}/data", { stuff: "stuff" }

    assert_equal 400, last_response.status
    assert_equal "Missing Payload - 400 Bad Request", last_response.body
  end

  def test_url_is_saved
    post '/sources', { "identifier" => "jumpstartlab", "rootUrl" => "http://jumpstartlab.com" }
    id = Registration.all.first.identifier

    post "/sources/#{id}/data", @raw_payload

    assert_equal "http://jumpstartlab.com/blog", Url.all.first[:url]
  end

  def test_if_the_payload_has_already_been_recieved
    post '/sources', { "identifier" => "facebook", "rootUrl" => "http://facebook.com" }
    id = Registration.all.first.identifier

    post "/sources/#{id}/data", @raw_payload
    post "/sources/#{id}/data", @raw_payload

    assert_equal 403, last_response.status
    assert_equal "Already Received Request - 403 Forbidden", last_response.body
  end
end
