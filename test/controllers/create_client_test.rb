require_relative '../test_helper'
require_relative '../../app/models/params_checker'

class CreateClientTest < Minitest::Test
  include TestHelpers
  include Rack::Test::Methods
  include ParamsChecker

  def test_registers_a_client_with_valid_attributes
    register_client

    assert_equal 1, Client.count
    assert_equal "jumpstartlab", Client.all.first.identifier
    assert_equal "http://jumpstartlab.com", Client.all.first.root_url
    assert_equal 200, last_response.status
    assert_equal "good request", last_response.body
  end

  def test_returns_correct_count_given_multiple_post
    register_client
    post '/sources', {}

    assert_equal 1, Client.all.count
  end

  def test_returns_error_for_an_invalid_root_url
    post '/sources', { identifier: "dfgdf", root_url: ""}

    assert_equal 0, Client.all.count
    assert_equal 401, last_response.status
    assert_equal "invalid root_url", last_response.body
  end

  def test_returns_error_for_an_invalid_identifier
    post '/sources', { identifier: "", root_url: "something"}

    assert_equal 0, Client.all.count
    assert_equal 401, last_response.status
    assert_equal "invalid identifier", last_response.body
  end

  def test_it_returns_403_for_a_duplicate_identifier
    register_client

    assert_equal 1, Client.count
    assert_equal "jumpstartlab", Client.all.first.identifier
    assert_equal "http://jumpstartlab.com", Client.all.first.root_url
    assert_equal 200, last_response.status
    assert_equal "good request", last_response.body

    register_client

    assert_equal 1, Client.count
    assert_equal "jumpstartlab", Client.all.first.identifier
    assert_equal "http://jumpstartlab.com", Client.all.first.root_url
    assert_equal 403, last_response.status
    assert_equal "identifier already registered", last_response.body
  end

  def test_it_accounts_for_one_identifier
    4.times {register_client}

    assert_equal 1, Client.count
  end

  def test_change_rootUrl_to_root_url
    params = {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}
    new_params = change_case(params)

    assert_equal [:identifier, :root_url], new_params.keys
    assert_equal params.values, new_params.values
  end
end
