require './spec/spec_helper'
require './app/models/url_payload_request_analyst'

RSpec.describe UrlPayloadRequestAnalyst, type: :model do

  before :each do
    DatabaseCleaner.start
    make_some_urls_and_payload_requests
  end

  after :each do
    DatabaseCleaner.clean
  end

  let(:up) { UrlPayloadRequestAnalyst.new }

  def make_some_urls_and_payload_requests
      urls = ["www.google.com", "www.jumpstartlab.com", "www.turing.io"]
      urls.each do |address|
        Url.create("address" => address)
      end

      [1,2,1,3,3,3].each do |url_id|
        PayloadRequest.create(
          "url_id"                =>  url_id,
          "requested_at"          =>  "2013-02-16 21:38:28 -0700",
          "responded_in"          =>  35,
          "source_id"             =>  2,
          "request_type_id"       =>  1,
          "u_agent_id"            =>  5,
          "screen_resolution_id"  =>  4,
          "ip_id"                 =>  6)
      end
  end

  it "lists most to least requested url" do
    result = up.most_to_least_requested_url
    urls = ["www.turing.io", "www.google.com", "www.jumpstartlab.com"]

    expect(result).to eq(urls)
  end

  it "groups paylod requests by url type" do
    result = up.group_by_url

    expect(result).to eq({3 => 3, 1 => 2, 2 => 1})
  end
end
