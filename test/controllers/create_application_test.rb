require_relative '../test_helper'

class CreateApplicationTest < Minitest::Test
  def test_it_creates_application_with_valid_attributes
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}


    assert_equal 200, last_response.status
    assert_equal 1, Application.count
    assert_equal "jumpstartlab", Application.all.last.identifier

    assert_equal "Application created.", last_response.body
  end

  def test_application_is_not_created_with_missing_idenfifier
    post '/sources', {rootUrl: "http://jumpstartlab.com"}

    assert_equal 400, last_response.status
    assert_equal 0, Application.count
  end

  def test_application_with_missing_idenfifier_returns_missing_id_message
    post '/sources', {rootUrl: "http://jumpstartlab.com"}

    assert_equal "Missing identifier.", last_response.body
  end

  def test_application_is_not_created_with_missing_rootUrl
    post '/sources', {identifier: "jumpstartlab"}

    assert_equal 400, last_response.status
    assert_equal 0, Application.count
  end

  def test_application_with_missing_url_returns_missing_url_message
    post '/sources', {identifier: "jumpstartlab"}

    assert_equal "Missing rootUrl.", last_response.body
  end

  def test_application_is_not_created_with_exiting_identifier
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    assert_equal 403, last_response.status
    assert_equal 1, Application.count
    assert_equal "Identifier already exists.", last_response.body
  end
end
