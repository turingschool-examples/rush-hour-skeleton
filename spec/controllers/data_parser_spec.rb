require './spec/spec_helper'
require './app/controllers/data_parser'

RSpec.describe DataParser, type: :model do

  after :each do
    DatabaseCleaner.clean
  end

  let(:dp) { DataParser.new(sample_payload) }
  let(:create_url) { Url.create("address" => "http://jumpstartlab.com/blog") }
  let(:create_source) { Source.create("address" => "http://jumpstartlab.com") }
  let(:create_request_type) { RequestType.create("verb" => "GET") }
  let(:create_ip_address) { IpAddress.create("address" => "63.29.38.211") }
  let(:create_screen_resolution) { ScreenResolution.create("width" => "1920", "height" => "1280") }
  let(:create_u_agent) { UAgent.create("browser" => u_agent[:browser],
                                       "operating_system" => u_agent[:operating_system]) }

  def u_agent
    parsed_sample_payload = JSON.parse(sample_payload)
    user_agent = UserAgent.new(parsed_sample_payload["userAgent"])
    { :browser => user_agent.name.to_s,
      :operating_system => user_agent.os }
  end

  def sample_payload
    JSON.generate({"url":"http://jumpstartlab.com/blog",
     "requestedAt":"2013-02-16 21:38:28 -0700",
     "respondedIn":37,
     "referredBy":"http://jumpstartlab.com",
     "requestType":"GET",
     "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
     "resolutionWidth":"1920",
     "resolutionHeight":"1280",
     "ip":"63.29.38.211"})
  end

  it "is initialized with a payload" do
    expect(dp.payload).to eq(sample_payload)
  end

  it "parses incoming json payload into ruby hash" do
    expect(dp.parse).to eq(JSON.parse(sample_payload))
  end

  it "checks if url exists in the urls table" do
    expect(dp.url_exists?).to eq(false)

    create_url

    expect(dp.url_exists?).to eq(true)
  end

  it "will create a new url object and return its id" do
    expect(dp.create_url_return_id).to eq(1)
  end

  it "will find a existing url object and return its id" do
    create_url
    expect(dp.return_existing_url_id).to eq(1)
  end

  it "will return a url id whether or not it finds a preexisting url" do
    2.times { expect(dp.url_id).to eq(1) }
  end

  it "checks if source exists in the sources table" do
    expect(dp.source_exists?).to eq(false)

    create_source

    expect(dp.source_exists?).to eq(true)
  end

  it "will create a new source object and return its id" do
    expect(dp.create_source_return_id).to eq(1)
  end

  it "will find a existing source object and return its id" do
    create_source
    expect(dp.return_existing_source_id).to eq(1)
  end

  it "will return a source id whether or not it finds a preexisting source" do
    2.times { expect(dp.source_id).to eq(1) }
  end

  it "checks if request type exists in the request types table" do
    expect(dp.request_type_exists?).to eq(false)

    create_request_type

    expect(dp.request_type_exists?).to eq(true)
  end

  it "will create a new request type object and return its id" do
    expect(dp.create_request_type_return_id).to eq(1)
  end

  it "will find a existing request type object and return its id" do
    create_request_type
    expect(dp.return_existing_request_type_id).to eq(1)
  end

  it "will return a request type id whether or not it finds a preexisting request type" do
    2.times { expect(dp.request_type_id).to eq(1) }
  end

  it "checks if ip address exists in the ip addresses table" do
    expect(dp.ip_address_exists?).to eq(false)

    create_ip_address

    expect(dp.ip_address_exists?).to eq(true)
  end

  it "will create a new ip address object and return its id" do
    expect(dp.create_ip_address_return_id).to eq(1)
  end

  it "will find a existing ip address object and return its id" do
    create_ip_address
    expect(dp.return_existing_ip_address_id).to eq(1)
  end

  it "will return a ip address id whether or not it finds a preexisting ip address" do
    2.times { expect(dp.ip_address_id).to eq(1) }
  end

  it "checks if u agent exists in the u agent table" do
    expect(dp.u_agent_exists?).to eq(false)

    create_u_agent

    expect(dp.u_agent_exists?).to eq(true)
  end

  it "will create a new u agent object and return its id" do
    expect(dp.create_u_agent_return_id).to eq(1)
  end

  it "will find a existing u agent object and return its id" do
    create_u_agent
    expect(dp.return_existing_u_agent_id).to eq(1)
  end

  it "will return a u agent id whether or not it finds a preexisting u agent" do
    2.times { expect(dp.u_agent_id).to eq(1) }
  end

  it "checks if screen resolution exists in the screen resolutions table" do
    expect(dp.screen_resolution_exists?).to eq(false)

    create_screen_resolution

    expect(dp.screen_resolution_exists?).to eq(true)
  end

  it "will create a new screen resolution object and return its id" do
    expect(dp.create_screen_resolution_return_id).to eq(1)
  end

  it "will find a existing screen resolution object and return its id" do
    create_screen_resolution
    expect(dp.return_existing_screen_resolution_id).to eq(1)
  end

  it "will return a screen resolution id whether or not it finds a preexisting screen resolution" do
    2.times { expect(dp.screen_resolution_id).to eq(1) }
  end

  it "parses a payload" do
    parsed_payload = {
      "url_id" => 1,
      "requested_at" => "2013-02-16 21:38:28 -0700",
      "responded_in" => 37,
      "source_id" => 1,
      "request_type_id" => 1,
      "u_agent_id" => 1,
      "screen_resolution_id" => 1,
      "ip_address_id" => 1
    }
    expect(dp.parse_payload).to eq(parsed_payload)
  end


end
