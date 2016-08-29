require_relative '../test_helper'
class ServerTest < Minitest::Test
  include TestHelpers


  def populate_clients
    Client.create({"identifier"=>"chase", "root_url"=>"http://chaselounge.com"})
    Client.create({"identifier"=>"jasmin", "root_url"=>"http://jasmin.io"})
    Client.create({"identifier"=>"sonia", "root_url"=>"http://soniagupta.com"})
  end

  def populate_payloads
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 1,
              u_agent_id: 1,
              resolution_id: 1,
              ip_id: 2,
              client_id: 1
            })
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 1,
              u_agent_id: 1,
              resolution_id: 1,
              ip_id: 2,
              client_id: 2
            })
    PayloadRequest.create({ url_id: 1,
              requested_at: "date",
              responded_in: 34,
              referred_by_id: 1,
              request_type_id: 1,
              u_agent_id: 1,
              resolution_id: 1,
              ip_id: 2,
              client_id: 3
            })
  end

  def raw_client_payload_data
    {"payload"=>"{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}", "splat"=>[], "captures"=>["jumpstartlab"], "identifier"=>"jumpstartlab"}
  end

  def test_it_can_register_a_new_client
    post '/sources', {"identifier"=>"jumpstartlab", "rootUrl"=>"http://jumpstartlab.com"}

    assert_equal 200, last_response.status
    assert_equal 1, Client.count
    assert_equal "Success!", last_response.body
    # assert last_response.body.include?("{'identifier':'jumpstartlab'}")
  end

  def test_it_returns_error_if_client_missing_parameters
    post '/sources', {"rootUrl"=>"http://jumpstartlab.com"}
    assert_equal 400, last_response.status
    assert_equal "Missing Parameters", last_response.body
    assert_equal 0, Client.count
  end

  def test_it_returns_error_if_client_identifier_already_exists
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

  def test_it_returns_error_if_payload_empty #broken
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

    # empty_payload = {"payload"=> nil, "splat"=>[], "captures"=>["jumpstartlab"], "identifier"=>"jumpstartlab"}

    post "/sources/jumpstartlab/data"



    assert_equal 400, last_response.status
    assert_equal "Missing payload", last_response.body
  end

  def test_it_returns_error_if_payload_already_exists
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

    assert_equal 0, PayloadRequest.all.count

    post "/sources/#{raw_client_payload_data["identifier"]}/data", raw_client_payload_data

    assert_equal 1, PayloadRequest.all.count

    post "/sources/#{raw_client_payload_data["identifier"]}/data", raw_client_payload_data

    assert_equal 403, last_response.status
    assert_equal "Already received", last_response.body
    assert_equal 1, PayloadRequest.all.count
  end

  def test_it_returns_error_if_client_has_not_previously_registered
    post "/sources/#{raw_client_payload_data["identifier"]}/data", raw_client_payload_data

    assert_equal 403, last_response.status
    assert_equal "Application not registered", last_response.body
  end

  def test_it_saves_payload_request_sent_by_client
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")

    assert_equal 0, PayloadRequest.all.count

    post "/sources/#{raw_client_payload_data["identifier"]}/data", raw_client_payload_data

    assert_equal 1, PayloadRequest.all.count
    assert_equal 200, last_response.status
    assert_equal "Success", last_response.body
  end

end
