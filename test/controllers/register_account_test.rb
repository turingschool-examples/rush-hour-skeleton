require './test/test_helper'

class RegisterAccountTest < Minitest::Test
  include Rack::Test::Methods

  def test_user_can_successfully_register_an_account
    post '/sources', { registration_data: { identifier: "jumpstartlab",
                                            rootUrl: "http://jumpstartlab.com" } }
    assert Client.registered?
    assert_equal 200, last_response.status
    assert_equal ({"identifier"=>"jumpstartlab"}), last_response.body
  end

  def test_user_receives_response_missing_parameters_without_identifier
    post '/sources', { registration_data: { rootUrl: "http://jumpstartlab.com" } }
    refute Client.registered?
    assert_equal 400, last_response.status
    assert_equal "Invalid Parameters", last_response.body
  end

  def test_user_receives_response_missing_parameters_without_rooturl
    post '/sources', { registration_data: { identifier: "jumpstartlab"} }
    refute Client.registered?
    assert_equal 400, last_response.status
    assert_equal "Invalid Parameters", last_response.body
  end

  def test_user_receives_response_identifier_already_exists
    post '/sources', { registration_data: { identifier: "jumpstartlab",
                                            rootUrl: "http://jumpstartlab.com" } }
    assert Client.registered?
    post '/sources', { registration_data: { identifier: "jumpstartlab",
                                            rootUrl: "http://jumpstartlab.com" } }
    assert Client.registered?
    assert_equal 403, last_response.status
    assert_equal "identifier Already Exists", last_response.body
  end

end
