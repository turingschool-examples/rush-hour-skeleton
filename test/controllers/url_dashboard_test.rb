require_relative '../test_helper'

class GetCorrectUrlDashboardTest < Minitest::Test
  include TestHelpers

  def test_gets_correct_route_when_url_exist

      create_payload_url
      get '/sources/Client69/urls/blog'
      assert_equal 200, last_response.status
      expected = "This page provides detailed traffic analytics"
      assert_equal true, last_response.body.include?(expected)
      expected = "http://jumpstartlab.com/blog"
      assert_equal true, last_response.body.include?(expected)
      assert_equal true, last_response.body.include?("69")

    end

    def test_gets_correct_route_when_url_reqs_do_not_exist

      Client.create(identifier: "Client69", root_url: "www.client69.com")
      Url.create(address: "www.client69.com/test")
      Url.create(address: "www.client69.com/test2")
      PayloadRequest.create(requested_at: "2013-02-16 21:38:28 -0700",
      responded_in: 69,
      referred_by_id: 1,
      request_type_id: 1,
      parameter_id: "[]",
      software_agent_id: 1,
      resolution_id: 1,
      ip_id: 1,
      url_id: 1,
      client_id: 1)

      get '/sources/Client69/urls/test2'
      assert_equal 200, last_response.status
      expected = "No Data for test2 for Client69"
      assert_equal true, last_response.body.include?(expected)

    end
  end
