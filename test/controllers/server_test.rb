require_relative '../test_helper'

class ServerTest < Minitest::Test
  include TestHelpers

  def test_it_can_take_in_params_and_return_200_status
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

  def test_it_returns_403_status_if_identifier_already_exists
    params = {"identifier" => "jumpstartlab", "rootUrl" => "http://test.com"}
    post '/sources', params

    assert_equal 403, last_response.status
    assert_equal "Identifier has already been taken", last_response.body
  end

end
