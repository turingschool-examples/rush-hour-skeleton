require './spec/spec_helper'
require './app/models/request_type_payload_request_analyst'

RSpec.describe RequestTypePayloadRequestAnalyst, type: :model do

  before :each do
    DatabaseCleaner.start
    make_some_request_types_and_payload_requests
  end

  after :each do
    DatabaseCleaner.clean
  end

  let(:rp) { RequestTypePayloadRequestAnalyst.new }

  def make_some_request_types_and_payload_requests
      ["GET", "POST", "PUT", "DELETE"].each do |verb|
        RequestType.create("verb" => verb)
      end

      [1,3,1].each do |request_type_id|
        PayloadRequest.create(
          "url_id"                =>  1,
          "requested_at"          =>  "2013-02-16 21:38:28 -0700",
          "responded_in"          =>  35,
          "source_id"             =>  2,
          "request_type_id"       =>  request_type_id,
          "u_agent_id"            =>  5,
          "screen_resolution_id"  =>  4,
          "ip_id"                 =>  6)
      end
  end

  it "knows the most frequent request type" do
    expect(rp.most_frequent_request_type).to eq("GET")
  end

  it "lists all HTTP verbs used" do
    expect(rp.list_verbs).to eq(["GET", "PUT"])
  end

  it "groups by request type" do
    expect(rp.group_by_request_type).to eq({1=>2, 3=>1})
  end
end
