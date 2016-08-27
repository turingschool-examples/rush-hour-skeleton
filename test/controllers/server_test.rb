require_relative '../test_helper'
class ServerTest < Minitest::Test
  include TestHelpers
  def populate_clients
    Client.create({"identifier"=>"chase", "root_url"=>"http://chaselounge.com"})
    Client.create({"identifier"=>"jasmin", "root_url"=>"http://jasmin.io"})
    Client.create({"identifier"=>"sonia", "root_url"=>"http://soniagupta.com"})
  end

  def test_it_can_create_a_client
    post '/sources', {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}

    assert_equal 200, last_response.status
    assert_equal 1, Client.count
    assert_equal "Success!", last_response.body
    # assert last_response.body.include?("{'identifier':'jumpstartlab'}")
  end

  def test_it_returns_error_if_client_invalid
    post '/sources', {"rootUrl"=>"http://jumpstartlab.com"}
    assert_equal 400, last_response.status
    assert_equal "Missing Parameters", last_response.body
    assert_equal 0, Client.count
  end

  def test_it_returns_error_if_client_already_exists
    post '/sources', {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}

    assert_equal 1, Client.count

    post '/sources', {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}

    assert_equal 403, last_response.status
    assert_equal 1, Client.count
    assert_equal "Identifier Already Exists", last_response.body
  end

  def test_it_can_deal_with_multiple_clients
    populate_clients
    post '/sources', {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}

    assert_equal 200, last_response.status
    assert_equal 4, Client.count
    assert_equal "Success!", last_response.body
  end

end
