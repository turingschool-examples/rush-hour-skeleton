require_relative '../test_helper'

class ServerTest < Minitest::Test
  include Rack::Test::Methods

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
end
