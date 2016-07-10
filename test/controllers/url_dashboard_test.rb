require_relative '../test_helper'

class GetCorrectUrlDashboardTest < Minitest::Test
  include TestHelpers

  def test_gets_correct_route_when_url_exist
    def create_payload
      url            =  Url.find_or_create_by(address: "http://jumpstartlab.com/blog")
      requested_at   =  Time.now
      request_type   =  RequestType.create(verb: "GET")
      resolution     =  Resolution.create(width: "1920", height: "1280")
      referrer       =  Referrer.create(address: "http://jumpstartlab.com")
      software_agent =  SoftwareAgent.create(os: "OSX 10.11.5", browser: "Chrome")
      ip             =  Ip.create(address: "63.29.38.211")
      client         =  Client.find_or_create_by(identifier: "Client69", root_url: "http://jumpstartlab.com")
      parameter      =  Parameter.find_or_create_by({user_input: []})

      payload = PayloadRequest.find_or_create_by({
        :url_id => url.id,
        :requested_at => requested_at,
        :responded_in => 69,
        :request_type_id => request_type.id,
        :resolution_id => resolution.id,
        :referred_by_id => referrer.id,
        :software_agent_id => software_agent.id,
        :ip_id => ip.id,
        :parameter_id => parameter.id,
        :client_id => client.id })
      end
      create_payload
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
