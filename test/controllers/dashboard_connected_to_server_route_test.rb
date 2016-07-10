require_relative '../test_helper'

class GetCorrectClientDashboardTest < Minitest::Test
  include TestHelpers



  def test_gets_correct_route_when_client_and_payload_reqs_exist
    def create_payload
      url            =  Url.find_or_create_by(address: "http://jumpstartlab.com/blog")
      requested_at   =  Time.now
      request_type   =  RequestType.create(verb: "GET")
      resolution     =  Resolution.create(width: "1920", height: "1280")
      referrer       =  Referrer.create(address: "http://jumpstartlab.com")
      software_agent =  SoftwareAgent.create(os: "OSX 10.11.5", browser: "Chrome")
      ip             =  Ip.create(address: "63.29.38.211")
      client         =  Client.find_or_create_by(identifier: "Client69", root_url: "www.wipitgood.com")
      parameter      =  Parameter.find_or_create_by({user_input: []})

      payload = PayloadRequest.find_or_create_by({
          :url_id => url.id,
          :requested_at => requested_at,
          :responded_in => 1,
          :request_type_id => request_type.id,
          :resolution_id => resolution.id,
          :referred_by_id => referrer.id,
          :software_agent_id => software_agent.id,
          :ip_id => ip.id,
          :parameter_id => parameter.id,
          :client_id => client.id })
        end
    create_payload


    get '/sources/Client69'
    assert_equal 200, last_response.status
    expected = "You are viewing the data for wipitgood"
    # assert_equal true, last_response.body.include?(expected)
    # assert_equal true, last_response.body.include?("GET")
    # assert_equal true, last_response.body.include?("48")

  end

  # def test_gets_correct_route_when_client_exists_without_payload
  #   Client.create(identifier: "Client2", root_url: "www.client2.com")
  #   get '/sources/Client2'
  #   assert_equal 200, last_response.status
  #   expected = "There is no payload data"
  #   assert_equal true, last_response.body.include?(expected)
  # end
  #
  # def test_gets_correct_route_when_dashboard_request_for_invalid_client
  #   get '/sources/Client3'
  #   assert_equal 200, last_response.status
  #   expected = "Client3 does not exist"
  #   assert_equal true, last_response.body.include?(expected)
  # end

end
