require_relative '../test_helper'

class GetCorrectClientDashboardTest < Minitest::Test
  include TestHelpers



  def test_gets_correct_route_when_client_and_payload_reqs_exist

    create_payload_controller

    get '/sources/Client69'
    assert_equal 200, last_response.status
    expected = "You are viewing the data for Client69"
    assert_equal true, last_response.body.include?(expected)
    assert_equal true, last_response.body.include?("GET")
    assert_equal true, last_response.body.include?("69")

  end
end
