require './test/test_helper'

class RegistrationTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_registers_with_identifier_and_root_url
    post '/sources',{ "identifier" => {"identifier": "username", "rootUrl": "http://turing.io"}.to_json}
    t = Client.last
    assert_equal "username", t.identifier
    assert_equal "http://turing.io", t.root_url
    assert_equal 200, last_response.status
    message = ({"identifier"=>t.identifier})
    assert_equal message , JSON.parse(last_response.body)
  end

  def test_it_stores_client_identifier
    post '/sources', { "identifier" => {"identifier": "username", "rootUrl": "http://turing.io"}.to_json}
    t = Client.last
    assert_equal "username", t.identifier
  end

  def test_it_reports_missing_title
    post '/sources', { "identifier" => {"rootUrl": "http://turing.io"}.to_json}
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_it_reports_missing_root_url
    post '/sources', { "identifier" => {"identifier": "username" }.to_json}
    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end

  def test_it_reports_duplicate_identifier
    post '/sources', { "identifier" => {"identifier": "username", "rootUrl": "http://turing.io"}.to_json}
    assert_equal 200, last_response.status
    post '/sources', { "identifier" => {"identifier": "username", "rootUrl": "http://turing.io"}.to_json}
    assert_equal 403, last_response.status
    assert_equal "Identifier has already been taken", last_response.body
  end

end
