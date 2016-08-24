require './spec/spec_helper'
require './app/models/payload_request'

RSpec.describe PayloadRequest, type: :model do

  let(:payload) { PayloadRequest.new(
    "url"=>"http://jumpstartlab.com/blog",
    "requested_at"=>"2013-02-16 21:38:28 -0700",
    "responded_in"=>37,
    "referred_by"=>"http://jumpstartlab.com",
    "request_type"=>"GET",
    "user_agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolution_width"=>"1920",
    "resolution_height"=>"1280",
    "ip"=>"63.29.38.211")}

  let(:malformed_payload) { PayloadRequest.new(
    "url"=> nil,
    "requested_at"=>"2013-02-16 21:38:28 -0700",
    "responded_in"=>37,
    "referred_by"=>"http://jumpstartlab.com",
    "request_type"=>"GET",
    "user_agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    "resolution_width"=>"1920",
    "resolution_height"=>"1280",
    "ip"=>"63.29.38.211")}

  it "takes a payload and returns a payload request object" do
    expect(payload).to be_an_instance_of PayloadRequest
  end

  it "has a url" do
    expect(payload.url).to eq("http://jumpstartlab.com/blog")
  end

  it "has a date" do
    expect(payload.requested_at).to eq("2013-02-16 21:38:28 -0700")
  end

  it "has a responded in" do
    expect(payload.responded_in).to eq(37)
  end

  it "has a referred by" do
    expect(payload.referred_by).to eq("http://jumpstartlab.com")
  end

  it "has a request type" do
    expect(payload.request_type).to eq("GET")
  end

  it "has a user_agent" do
    expect(payload.user_agent).to eq("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
  end

  it "has a resolution width" do
    expect(payload.resolution_width).to eq("1920")
  end

  it "has a resolution height" do
    expect(payload.resolution_height).to eq("1280")
  end

  it "has an ip address" do
    expect(payload.ip).to eq("63.29.38.211")
  end

  it "will not create a payload request without a url" do
    expect(PayloadRequest.create(:url => "")).to be_invalid
  end

  it "will not create a payload request without a requested_at" do
    expect(PayloadRequest.create(:requested_at => "")).to be_invalid
  end

  it "will not create a payload request without a responded_in" do
    expect(PayloadRequest.create(:responded_in => "")).to be_invalid
  end

  it "will not create a payload request without a referred_by" do
    expect(PayloadRequest.create(:referred_by => "")).to be_invalid
  end

  it "will not create a payload request without a request_type" do
    expect(PayloadRequest.create(:request_type => "")).to be_invalid
  end

  it "will not create a payload request without a user_agent" do
    expect(PayloadRequest.create(:user_agent => "")).to be_invalid
  end

  it "will not create a payload request without a resolution_width" do
    expect(PayloadRequest.create(:resolution_width => "")).to be_invalid
  end

  it "will not create a payload request without a resolution_height" do
    expect(PayloadRequest.create(:resolution_height => "")).to be_invalid
  end

  it "will not create a payload request without an ip" do
    expect(PayloadRequest.create(:ip => "")).to be_invalid
  end
end
