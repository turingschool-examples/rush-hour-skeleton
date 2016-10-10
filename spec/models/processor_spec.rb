require_relative '../spec_helper'
require 'pry'

describe Processor do
  it "returns hash with proper root_url key case" do
    params = {identifier: "test_id", rootUrl: "test_url"}
    expected = {identifier: "test_id", root_url: "test_url"}

    expect(Processor.clean_data(params)).to eq(expected)
  end

  it "returns nil root_url if rootUrl case is incorrect" do
    params = {identifier: "test_id", root_url: "test_url"}
    expected = {identifier: "test_id", root_url: nil}

    expect(Processor.clean_data(params)).to eq(expected)
  end

  it "returns referred by ID" do
    pc = Processor.params_cleaner(test_data)

    expect(pc[:referred_by_id]).to eq(ReferredBy.find_by(root_url: "jumpstartlab.com").id)
  end

  it "returns agent by ID" do
    pc = Processor.params_cleaner(test_data)

    expect(pc[:agent_id]).to eq(Agent.find_by(browser: "Chrome", operating_system: "Macintosh%3B Intel Mac OS X 10_8_2" ).id)
  end

  it "returns event by ID" do
    pc = Processor.params_cleaner(test_data)

    expect(pc[:event_id]).to eq(Event.find_by(event_name: "socialLogin").id)
  end

  it "returns ip by ID" do
    pc = Processor.params_cleaner(test_data)

    expect(pc[:ip_id]).to eq(Ip.find_by(address: "63.29.38.211").id)
  end

  it "returns request_type by ID" do
    pc = Processor.params_cleaner(test_data)

    expect(pc[:request_type_id]).to eq(RequestType.find_by(http_verb: "GET").id)
  end

  it "returns resolution by ID" do
    pc = Processor.params_cleaner(test_data)

    expect(pc[:resolution_id]).to eq(Resolution.find_by(width: "1920", height: "1280").id)
  end

  it "returns json parsed hash" do
    pc = Processor.json_parser(test_data)
    expected = {"url"=>"http://jumpstartlab.com/blog",
                "requestedAt"=>"2013-02-16 21:38:28 -0700",
                "respondedIn"=>37,
                "referredBy"=>"http://jumpstartlab.com",
                "requestType"=>"GET",
                "eventName"=>"socialLogin",
                "userAgent"=>"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                "resolutionWidth"=>"1920",
                "resolutionHeight"=>"1280",
                "ip"=>"63.29.38.211"}

    expect(pc).to eq(expected)
  end


end
