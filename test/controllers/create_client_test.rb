require_relative '../test_helper'

class ServerTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def test_complete_request
    post '/sources', {"identifier" => "turing", "rootUrl"=>"turing.io"}
    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "Client created", last_response.body
  end

  def test_client_with_missing_identifier
    post '/sources', {"rootUrl"=>"turing.io"}
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_client_with_missing_root_url
    post '/sources', {"identifier" => "turing"}
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end

  def test_client_already_created
    post '/sources', {"identifier" => "turing", "rootUrl"=>"turing.io"}
    post '/sources', {"identifier" => "turing", "rootUrl"=>"turing.io"}
    assert_equal 403, last_response.status
    assert_equal "Client already exists", last_response.body
  end

end
