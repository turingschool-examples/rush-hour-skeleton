require_relative '../test_helper'
class RushHourAppTest < Minitest::Test
  include TestHelpers


  def test_the_application_can_create_a_client
    post '/sources', {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    assert_equal 200, last_response.status
    assert_equal "Client creation successful!", last_response.body
    assert_equal 1, Client.count
  end

  def test_the_application_errors_403_if_client_already_exists
    post '/sources',  {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}
    post '/sources',  {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}

    assert_equal 403, last_response.status
    assert_equal "Client already exists.", last_response.body
    assert_equal 1, Client.count
  end

  def test_the_application_errors_400_if_client_is_invalid
    post '/sources', {rootUrl: "http://jumpstartlab.com"}

    assert_equal 400, last_response.status
    assert_equal "Client identifier or root url not provided.", last_response.body
    assert_equal 0, Client.count
  end


end
