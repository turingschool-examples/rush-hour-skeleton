require './spec/spec_helper'
require './app/controllers/server'

RSpec.describe RushHour::Server, type: :model do
  def app
    RushHour::Server
  end

  after :each do
    DatabaseCleaner.clean
  end

  def create_client
    Client.create("identifier" => "jumpstartlab",
      "root_url" => "www.jumpstartlab.com")
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
    create_client


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

  def invalid_payload(key)
    payload = JSON.parse(valid_payload)
    payload[key] = ""
    return JSON.generate(payload)
  end

  def valid_payload
    '{"url":"http://jumpstartlab.com/blog",
     "requestedAt":"2013-02-16 21:38:28 -0700",
     "respondedIn":37,
     "referredBy":"http://jumpstartlab.com",
     "requestType":"GET",
     "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
     "resolutionWidth":"1920",
     "resolutionHeight":"1280",
     "ip":"63.29.38.211"}'
  end

  def first_payload_request
    payload_request = {"url_id"=>1,
    "requested_at"=>"2013-02-16 21:38:28 -0700",
    "responded_in"=>37,
    "source_id"=>1,
    "request_type_id"=>1,
    "u_agent_id"=>1,
    "screen_resolution_id"=>1,
    "ip_address_id"=>1,
    "client_id"=>1}
  end

  def payload_error_message
    "Parameters must include url, requestedAt, respondedIn, referredBy, requestType, userAgent, resolutionWidth, resolutionHeight and ip."
  end

  it "knows if payload request contains all payload request paramters" do
    create_client

    post '/sources/jumpstartlab/data', {"payload" => invalid_payload("url"),
                                        "identifier"=> "jumpstartlab"}

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', {"payload" => invalid_payload("requestedAt"),
                                        "identifier"=> "jumpstartlab"}

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', {"payload" => invalid_payload("respondedIn"),
                                        "identifier"=> "jumpstartlab"}
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', {"payload" => invalid_payload("referredBy"),
                                        "identifier"=> "jumpstartlab"}

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', {"payload" => invalid_payload("requestType"),
                                        "identifier"=> "jumpstartlab"}

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', {"payload" => invalid_payload("userAgent"),
                                        "identifier"=> "jumpstartlab"}
    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', {"payload" => invalid_payload("resolutionWidth"),
                                        "identifier"=> "jumpstartlab"}

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', {"payload" => invalid_payload("resolutionHeight"),
                                        "identifier"=> "jumpstartlab"}

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', {"payload" => invalid_payload("ip"),
                                        "identifier"=> "jumpstartlab"}

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)

    # post '/sources/jumpstartlab/data', {"payload" => valid_payload,
    #                                     "identifier" => ""}
    #
    # expect(last_response.status).to eq(400)
    # expect(last_response.body).to eq(payload_error_message)

    post '/sources/jumpstartlab/data', {"identifier"=> "jumpstartlab"}

    expect(last_response.status).to eq(400)
    expect(last_response.body).to eq(payload_error_message)
    # post '/sources/jumpstartlab/data', invalid_payload("client_id")
    #
    # expect(last_response.status).to eq(400)
    # expect(last_response.body).to eq(payload_error_message)
  end

  # it "can parse the identifier from a post request" do
  #   post '/sources/jumpstartlab/data', {"payload" => valid_payload}
  #   expect(last_request.path_info).to eq("/sources/jumpstartlab/data")
  # end

  it "returns status 403 if payload request already exists" do
    PayloadRequest.create(first_payload_request)
    create_client

    post '/sources/jumpstartlab/data', {"payload" => valid_payload, "identifier"=> "jumpstartlab"}

    expect(last_response.status).to eq(403)
    expect(last_response.body).to eq("Payload request already exists")
  end

  it "returns status 403 if application does not exist" do
    post '/sources/jumpstartlab/data', {"payload" => valid_payload }

    expect(last_response.status).to eq(403)
    expect(last_response.body).to eq("Application does not exist")
  end

  it "returns status 200 and identifier message when it creates a new payload request" do
    create_client
    expect(PayloadRequest.all.count).to eq(0)
    post '/sources/jumpstartlab/data', {"payload" => valid_payload, "identifier"=> "jumpstartlab"}

    expect(last_response.status).to eq(200)
    expect(PayloadRequest.all.count).to eq(1)
  end

end
