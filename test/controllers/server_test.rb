require_relative '../test_helper'

class ServerTest < Minitest::Test
  include Rack::Test::Methods
  include TestHelpers

  def app
    RushHour::Server
  end

  def test_handles_missing_root_url
    post "/sources", { identifier: "jumpstartlab", rootUrl: "" }

    refute_equal 1, Client.count
    assert_equal 400, last_response.status
    assert_equal "400 Bad Request - Root url can't be blank", last_response.body
  end

  def test_handles_missing_identifier
    post "/sources", { identifier: "", rootUrl: "google.com" }

    refute_equal 1, Client.count
    assert_equal 400, last_response.status
    assert_equal "400 Bad Request - Identifier can't be blank", last_response.body
  end

  def test_handles_missing_parameters
    post "/sources", { identifier: "", rootUrl: "" }

    refute_equal 1, Client.count
    assert_equal 400, last_response.status
    assert_equal "400 Bad Request - Identifier can't be blank, Root url can't be blank", last_response.body
  end

  def test_handles_existing_identifier
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    post "/sources", {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    refute_equal 2, Client.count
    assert_equal 403, last_response.status
    assert_equal "403 Forbidden - Identifier already exists", last_response.body
  end

  def test_handles_success
    post "/sources", { identifier: "jumpstartlab",
                       rootUrl:    "https://jumpstartlab.com" }

    expected = { identifier: "jumpstartlab" }.to_json

    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal expected, last_response.body
  end

  def test_missing_payload
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', { payload: "{}" }

    assert_equal 400, last_response.status
    assert_equal "400 Bad Request - Missing payload request", last_response.body
  end

  def test_already_received_request
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', { payload: payload.to_json }
    post '/sources/jumpstartlab/data', { payload: payload.to_json }

    assert_equal 403, last_response.status
    assert_equal "403 Forbidden - Identifier already exists", last_response.body
  end

  def test_application_not_registered
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    post '/sources/hopstartlab/data', { payload: payload.to_json }

    assert_equal 403, last_response.status
    assert_equal "403 Forbidden - Application not registered", last_response.body
  end

  def test_successful_request
    Client.create(identifier: "humpstartlab", root_url: "http://humpstartlab.com")
    post '/sources/humpstartlab/data', {payload: payload.to_json}

    assert_equal 200, last_response.status
  end
end
