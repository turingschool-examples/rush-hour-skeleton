require './spec/spec_helper'
require './app/models/url'

RSpec.describe Url, type: :model do

  before :each do
    DatabaseCleaner.start
    make_some_urls_and_payload_requests
  end

  after :each do
    DatabaseCleaner.clean
  end

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

  let(:url) { Url.new("address" =>"http://jumpstartlab.com/blog")}

  it "takes a url and returns a url object" do
    expect(url).to be_an_instance_of Url
  end

  it "has a url address" do
    expect(url.address).to eq("http://jumpstartlab.com/blog")
  end

  it "will not create a url without a url" do
    expect(Url.new("address" => "")).to be_invalid
  end

  it "will not allow duplicate addresses" do
    Url.create("address" =>"http://jumpstartlab.com/blog")
    expect(Url.new("address" => "http://jumpstartlab.com/blog")).to be_invalid
  end

  it "lists most to least requested url" do
    result = Url.most_to_least_requested_url
    urls = ["www.turing.io", "www.google.com", "www.jumpstartlab.com"]

    expect(result).to eq(urls)
  end

  it "groups paylod requests by url type" do
    result = Url.group_by_url

    expect(result).to eq({3 => 3, 1 => 2, 2 => 1})
  end

end
