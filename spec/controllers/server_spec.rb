require './spec/spec_helper'
require './app/controllers/server'

RSpec.describe RushHour::Server, type: :model do
  def app
    RushHour::Server
  end

  after :each do
    DatabaseCleaner.clean
  end

  it "knows if paramaters contain identifier and root_url" do
    post '/sources'
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq("Parameters must include identifier and rootUrl.")

    post '/sources', {"identifier" => "jumpstartlab"}
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq("Parameters must include identifier and rootUrl.")

    post '/sources', {"root_url" => "www.jumpstartlab.com"}
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq("Parameters must include identifier and rootUrl.")
  end

  it "returns status 403 if client already exists" do
    Client.create("identifier" => "jumpstartlab",
      "root_url" => "www.jumpstartlab.com")


    post '/sources', {"identifier" => "jumpstartlab",
                      "rootUrl" => "www.jumpstartlab.com"}

    expect(last_response.status).to eq(403)
    expect(last_response.body).to eq("Client already exists")
  end

  it "returns status 200 and identifier message when it creates a new client" do
    post '/sources', {"identifier" => "jumpstartlab",
                      "rootUrl" => "www.jumpstartlab.com"}

    expected_body = JSON.generate({"identifier" => "jumpstartlab"})
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq(expected_body)
  end

  def invalid_payload_request(key)
    payload_request = valid_payload_request
    payload_request[key] = ""
    return payload_request
  end

  def valid_payload_request
    payload_request = {"url_id"=>1,
    "requested_at"=>"2013-02-16 21:38:28 -0700",
    "responded_in"=>2,
    "source_id"=>3,
    "request_type_id"=>4,
    "u_agent_id"=>5,
    "screen_resolution_id"=>6,
    "ip_address_id"=>7,
    "client_id"=>8}
  end

  def payload_error_message
    "Parameters must include url, requestedAt, respondedIn, referredBy, requestType, userAgent, resolutionWidth, resolutionHeight and ip."
  end

  it "knows if payload request contains all payload request paramters" do
    Client.create("identifier" => "jumpstartlab",
      "root_url" => "www.jumpstartlab.com")

    post '/sources/jumpstartlab/data', invalid_payload_request("url_id")

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', invalid_payload_request("requested_at")

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', invalid_payload_request("responded_in")

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', invalid_payload_request("source_id")

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', invalid_payload_request("request_type_id")

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', invalid_payload_request("u_agent_id")

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', invalid_payload_request("screen_resolution_id")

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', invalid_payload_request("ip_address_id")

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', invalid_payload_request("client_id")

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)
  end

  skip "returns status 403 if payload request already exists" do
    PayloadRequest.create(valid_payload_request)


    # post '/sources/jumpstartlab/data', {"url" => }

    expect(last_response.status).to eq(403)
    expect(last_response.body).to eq("Client already exists")
  end

end
