require_relative '../test_helper'

class SourcesPathTest < ControllerTest

  def test_registration_returns_400_when_missing_identifier_parameter
    post '/sources', { "rootUrl" => "http://facebook.com" }

    assert_equal 400, last_response.status
    assert_equal "Missing Parameters - 400 Bad Request", last_response.body
  end

  def test_registration_returns_400_when_missing_root_url_parameter
    post '/sources', { "identifier" => "facebook" }

    assert_equal 400, last_response.status
    assert_equal "Missing Parameters - 400 Bad Request", last_response.body
  end

  def test_registration_is_successful
    post '/sources', { "identifier" => "facebook", "rootUrl" => "http://facebook.com" }

    assert_equal 200, last_response.status
    assert_equal "{'identifier' : 'facebook'}", last_response.body
  end

  def test_registration_data_when_successful
    post '/sources', { "identifier" => "facebook", "rootUrl" => "http://facebook.com" }

    assert_equal 'facebook', Registration.all.first.identifier
    assert_equal 'http://facebook.com', Registration.all.first.url
  end

  def test_registration_data_not_saved_when_unsuccessful
    post '/sources', { key: "invalid input" }

    assert_equal 0, Registration.all.count
  end

  def test_registration_returns_403_if_identified_already_exists
    post '/sources', { "identifier" => "facebook", "rootUrl" => "http://facebook.com" }

    assert_equal 1, Registration.all.count

    post '/sources', { "identifier" => "facebook", "rootUrl" => "http://facebook.com" }

    assert_equal 403, last_response.status
    assert_equal "Identifier Already Exists - 403 Forbidden", last_response.body
  end
end
