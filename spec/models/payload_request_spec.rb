require './spec/spec_helper'
require './app/models/payload_request'

RSpec.describe PayloadRequest, type: :model do
  # include TestHelpers
  after :each do
      DatabaseCleaner.clean
    end

  def create_dummy_plr_url_1
    PayloadRequest.create(
                "url_id"=>1,
                "requested_at"=>"2013-02-16 21:38:28 -0700",
                "responded_in"=>35,
                "source_id"=>2,
                "request_type_id"=>3,
                "u_agent_id"=>5,
                "screen_resolution_id"=>4,
                "ip_id"=>6)
  end

  let(:payload) { PayloadRequest.new(
    "url_id"=>1,
    "requested_at"=>"2013-02-16 21:38:28 -0700",
    "responded_in"=>37,
    "source_id"=>2,
    "request_type_id"=>3,
    "u_agent_id"=>5,
    "screen_resolution_id"=>4,
    "ip_id"=>6)}

  let(:malformed_payload) { PayloadRequest.new(
    "url_id"=> nil,
    "requested_at"=>"2013-02-16 21:38:28 -0700",
    "responded_in"=>37,
    "source_id"=>2,
    "request_type_id"=>3,
    "u_agent_id"=>5,
    "screen_resolution_id"=>4,
    "ip_id"=>6)}

  it "takes a payload and returns a payload request object" do
    expect(payload).to be_an_instance_of PayloadRequest
  end

  it "has a url id" do
    expect(payload.url_id).to eq(1)
  end

  it "has a date" do
    expect(payload.requested_at).to eq("2013-02-16 21:38:28 -0700")
  end

  it "has a responded in" do
    expect(payload.responded_in).to eq(37)
  end

  it "has a source_id" do
    expect(payload.source_id).to eq(2)
  end

  it "has a request type_id" do
    expect(payload.request_type_id).to eq(3)
  end

  it "has a u_agent_id" do
    expect(payload.u_agent_id).to eq(5)
  end

  it "has a screen_resolution_id width" do
    expect(payload.screen_resolution_id).to eq(4)
  end

  it "has an ip_id address" do
    expect(payload.ip_id).to eq(6)
  end

  it "will not create a payload request without a url id" do
    expect(PayloadRequest.new(:url_id => "")).to be_invalid
  end

  it "will not create a payload request without a requested_at" do
    expect(PayloadRequest.new(:requested_at => "")).to be_invalid
  end

  it "will not create a payload request without a responded_in" do
    expect(PayloadRequest.new(:responded_in => "")).to be_invalid
  end

  it "will not create a payload request without a source_id" do
    expect(PayloadRequest.new(:source_id => "")).to be_invalid
  end

  it "will not create a payload request without a request_type_id" do
    expect(PayloadRequest.new(:request_type_id => "")).to be_invalid
  end

  it "will not create a payload request without a u_agent_id" do
    expect(PayloadRequest.new(:u_agent_id => "")).to be_invalid
  end

  it "will not create a payload request without a screen_resolution_id" do
    expect(PayloadRequest.new(:screen_resolution_id => "")).to be_invalid
  end

  it "will not create a payload request without an ip_id" do
    expect(PayloadRequest.new(:ip_id => "")).to be_invalid
  end

  it "will find the average response time" do
    5.times { PayloadRequest.create(
                "url_id"=>1,
                "requested_at"=>"2013-02-16 21:38:28 -0700",
                "responded_in"=>35,
                "source_id"=>2,
                "request_type_id"=>3,
                "u_agent_id"=>5,
                "screen_resolution_id"=>4,
                "ip_id"=>6)}

    5.times { PayloadRequest.create(
                "url_id"=>1,
                "requested_at"=>"2013-02-16 21:38:28 -0700",
                "responded_in"=>37,
                "source_id"=>2,
                "request_type_id"=>3,
                "u_agent_id"=>5,
                "screen_resolution_id"=>4,
                "ip_id"=>6)}

    expect(PayloadRequest.all.length).to eq(10)
    expect(PayloadRequest.average_response_time).to eq(36)
  end

  it "will find the max response time" do
    [35, 30, 20].each do |requested_in|
    PayloadRequest.create(
                "url_id"=>1,
                "requested_at"=>"2013-02-16 21:38:28 -0700",
                "responded_in"=>requested_in,
                "source_id"=>2,
                "request_type_id"=>3,
                "u_agent_id"=>5,
                "screen_resolution_id"=>4,
                "ip_id"=>6)
              end

    expect(PayloadRequest.max_response_time).to eq(35)
  end

  it "will find the min response time" do
    [35, 30, 20].each do |requested_in|
    PayloadRequest.create(
                "url_id"=>1,
                "requested_at"=>"2013-02-16 21:38:28 -0700",
                "responded_in"=>requested_in,
                "source_id"=>2,
                "request_type_id"=>3,
                "u_agent_id"=>5,
                "screen_resolution_id"=>4,
                "ip_id"=>6)
              end

    expect(PayloadRequest.min_response_time).to eq(20)
  end

  it "will find max response time for a specific url" do
    [30, 20].each do |requested_in|
    PayloadRequest.create(
                "url_id"=>2,
                "requested_at"=>"2013-02-16 21:38:28 -0700",
                "responded_in"=>requested_in,
                "source_id"=>2,
                "request_type_id"=>3,
                "u_agent_id"=>5,
                "screen_resolution_id"=>4,
                "ip_id"=>6)
              end

    create_dummy_plr_url_1

    expect(PayloadRequest.url_max_response_time(2)).to eq(30)
  end

  it "will find min response time for a specific url" do
    [30, 20].each do |requested_in|
    PayloadRequest.create(
                "url_id"=>2,
                "requested_at"=>"2013-02-16 21:38:28 -0700",
                "responded_in"=>requested_in,
                "source_id"=>2,
                "request_type_id"=>3,
                "u_agent_id"=>5,
                "screen_resolution_id"=>4,
                "ip_id"=>6)
              end

    create_dummy_plr_url_1

    expect(PayloadRequest.url_min_response_time(2)).to eq(20)
  end

  it "will find all response times for a specific url in descending order" do
    [30, 20, 25].each do |requested_in|
    PayloadRequest.create(
                "url_id"=>2,
                "requested_at"=>"2013-02-16 21:38:28 -0700",
                "responded_in"=>requested_in,
                "source_id"=>2,
                "request_type_id"=>3,
                "u_agent_id"=>5,
                "screen_resolution_id"=>4,
                "ip_id"=>6)
              end

    create_dummy_plr_url_1

    expect(PayloadRequest.url_response_times(2)).to eq([30, 25, 20])
  end

  it "will find average response time for a specific url" do
    [30, 20].each do |requested_in|
    PayloadRequest.create(
                "url_id"=>2,
                "requested_at"=>"2013-02-16 21:38:28 -0700",
                "responded_in"=>requested_in,
                "source_id"=>2,
                "request_type_id"=>3,
                "u_agent_id"=>5,
                "screen_resolution_id"=>4,
                "ip_id"=>6)
              end

    create_dummy_plr_url_1

    expect(PayloadRequest.url_avg_response_time(2)).to eq(25)
  end
end
