require './test/test_helper'

class RegisterAccountTest < Minitest::Test
  include Rack::Test::Methods

  def test_user_can_successfully_register_an_account
    post '/sources', { "identifier" => "jumpstartlab",
                       "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
    assert_equal 1, Source.count
  end

  def test_user_receives_response_missing_parameters_without_identifier
    post '/sources', {"rootUrl" => "http://jumpstartlab.com"}
    assert_equal 0, Source.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_user_receives_response_missing_parameters_without_rooturl
    post '/sources', { "identifier" => "jumpstartlab"}
    assert_equal 0, Source.count
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end

  def test_user_receives_response_identifier_already_exists
    post '/sources', { "identifier" => "jumpstartlab",
                       "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 1, Source.count
    post '/sources', { "identifier" => "jumpstartlab",
                       "rootUrl" => "http://jumpstartlab.com" }
    assert_equal 1, Source.count
    assert_equal 403, last_response.status
    assert_equal "Identifier has already been taken," +
                 " Root url has already been taken",
                 last_response.body
  end

  def test_receives_response_missing_both_parameters
    post '/sources', {}
    assert_equal 0, Source.count
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank, Root url can't be blank", last_response.body
  end

end
