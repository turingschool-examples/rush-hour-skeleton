require './test/test_helper'

class RegisterAnApplication < ControllerTest

  def test_successful_registration_of_application
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    assert_equal 1, Site.count
    assert_equal 200, last_response.status
    assert_equal "{'identifier':'jumpstartlab'}", last_response.body
  end

  def test_identifier_already_exists
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    assert_equal 1, Site.count
    assert_equal 403, last_response.status
    assert_equal "Identifier has already been taken", last_response.body
  end

  def test_identifier_is_different_but_url_is_same
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    assert_equal 1, Site.count
    assert_equal 200, last_response.status
    assert_equal "{'identifier':'jumpstartlab'}", last_response.body
    post '/sources', { identifier: "jumpstartlab2", rootUrl: "http://jumpstartlab.com"}
    assert_equal 2, Site.count
    assert_equal 200, last_response.status
    assert_equal "{'identifier':'jumpstartlab2'}", last_response.body
  end

  def test_identifier_is_the_missing_parameter
    post '/sources', { rootUrl: "http://jumpstartlab.com" }
    assert_equal 0, Site.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_identifier_is_an_empty_string
    post '/sources', { identifier: "", rootUrl: "http://jumpstartlab.com" }
    assert_equal 0, Site.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_rootUrl_is_the_missing_parameter
    post '/sources', { identifier: "jumpstartlab" }
    assert_equal 0, Site.count
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end

  def test_rootUrl_is_an_empty_string
    post '/sources', { identifier: "jumpstartlab", rootUrl: "" }
    assert_equal 0, Site.count
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end

  def test_missing_both_parameters
    post '/sources', {}
    assert_equal 0, Site.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank, Root url can't be blank", last_response.body
  end
  
end