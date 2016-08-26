require './spec/spec_helper'
require './app/models/url'

RSpec.describe Url, type: :model do

  before :each do

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

  def make_some_urls_sources_and_payload_requests
      urls = ["www.jumpstartlab.com/blog", "www.turing.io/blog"]
      urls.each do |address|
        Url.create("address" => address)
      end

      sources = ["www.google.com", "www.jumpstartlab.com",
                 "www.turing.io", "www.yahoo.com"]
      sources.each do |address|
        Source.create("address" => address)
      end

      [[1,1],[1,1],[1,1],[1,1],[1,2],[1,2],[1,2],[1,3],[1,3],[1,4]].each do |source_id_url_id|
        PayloadRequest.create(
          "url_id"                =>  source_id_url_id[0],
          "requested_at"          =>  "2013-02-16 21:38:28 -0700",
          "responded_in"          =>  35,
          "source_id"             =>  source_id_url_id[1],
          "request_type_id"       =>  1,
          "u_agent_id"            =>  5,
          "screen_resolution_id"  =>  4,
          "ip_id"                 =>  6)
      end
  end

  def make_a_url_some_user_agents_and_payload_requests
      urls = Url.create("address" => "www.jumpstartlab.com/blog")

      u_agents = [["Chrome", "OSX"], ["Safari", "OSX"], ["Chrome", "Windows Vista"],
                  ["Chrome", "Linux"]]
      u_agents.each do |u_agent|
        UAgent.create("operating_system" => u_agent[1],
                      "browser" => u_agent[0])
      end

      [1,2,2,3,3,3,4,4,4,4,4].each do |u_agent_id|
        PayloadRequest.create(
          "url_id"                =>  1,
          "requested_at"          =>  "2013-02-16 21:38:28 -0700",
          "responded_in"          =>  35,
          "source_id"             =>  1,
          "request_type_id"       =>  1,
          "u_agent_id"            =>  u_agent_id,
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
    make_some_urls_and_payload_requests
    result = Url.most_to_least_requested_url
    urls = ["www.turing.io", "www.google.com", "www.jumpstartlab.com"]

    expect(result).to eq(urls)
  end

  it "groups paylod requests by url type" do
    make_some_urls_and_payload_requests
    result = Url.group_by_url

    expect(result).to eq({3 => 3, 1 => 2, 2 => 1})
  end

  it "knows the three most popular referrers for a specific url" do
    make_some_urls_sources_and_payload_requests
    address = "www.jumpstartlab.com/blog"

    result = [Source.find_by(:address => "www.google.com"),
              Source.find_by(:address => "www.jumpstartlab.com"),
              Source.find_by(:address => "www.turing.io")]
    actual = Url.find_by(:address => address).top_3_sources
    expect(actual.length).to eq(3)
    expect(actual).to eq(result)
  end

  it "knows the verbs associated with it" do
    url = Url.create(:address => "www.turing.io")
    verb = RequestType.create(:verb => "GET")
    payload_request = PayloadRequest.create(
      "url_id"                =>  url.id,
      "requested_at"          =>  "2013-02-16 21:38:28 -0700",
      "responded_in"          =>  35,
      "source_id"             =>  5,
      "request_type_id"       =>  verb.id,
      "u_agent_id"            =>  5,
      "screen_resolution_id"  =>  4,
      "ip_id"                 =>  6)

    expect(url.verbs).to include(verb)
  end

  it "knows the three most popular user agents for a specific url" do
    make_a_url_some_user_agents_and_payload_requests
    address = "www.jumpstartlab.com/blog"

    result = [UAgent.find_by(:id => 4),
              UAgent.find_by(:id => 3),
              UAgent.find_by(:id => 2)]

    actual = Url.find_by(:address => address).top_3_u_agents

    expect(actual.length).to eq(3)
    expect(actual).to eq(result)
  end


    it "will find max response time for a specific url" do
      url = Url.create("address" => "http://www.google.com")
      [30, 20].each do |responded_in|
      PayloadRequest.create(
                  "url_id"=>url.id,
                  "requested_at"=>"2013-02-16 21:38:28 -0700",
                  "responded_in"=>responded_in,
                  "source_id"=>2,
                  "request_type_id"=>3,
                  "u_agent_id"=>5,
                  "screen_resolution_id"=>4,
                  "ip_id"=>6)
                end


      expect(url.url_max_response_time).to eq(30)
    end

    it "will find min response time for a specific url" do
      url = Url.create("address" => "http://www.google.com")
      [30, 20].each do |responded_in|
      PayloadRequest.create(
                  "url_id"=>url.id,
                  "requested_at"=>"2013-02-16 21:38:28 -0700",
                  "responded_in"=>responded_in,
                  "source_id"=>2,
                  "request_type_id"=>3,
                  "u_agent_id"=>5,
                  "screen_resolution_id"=>4,
                  "ip_id"=>6)
                end


      expect(url.url_min_response_time).to eq(20)
    end

    it "will find all response times for a specific url in descending order" do
      url = Url.create("address" => "http://www.google.com")
      [30, 20, 25].each do |responded_in|
      PayloadRequest.create(
                  "url_id"=>url.id,
                  "requested_at"=>"2013-02-16 21:38:28 -0700",
                  "responded_in"=>responded_in,
                  "source_id"=>2,
                  "request_type_id"=>3,
                  "u_agent_id"=>5,
                  "screen_resolution_id"=>4,
                  "ip_id"=>6)
                end


      expect(url.url_response_times).to eq([30, 25, 20])
    end

    it "will find average response time for a specific url" do
      url = Url.create("address" => "http://www.google.com")
      [30, 20].each do |responded_in|
      PayloadRequest.create(
                  "url_id"=>url.id,
                  "requested_at"=>"2013-02-16 21:38:28 -0700",
                  "responded_in"=>responded_in,
                  "source_id"=>2,
                  "request_type_id"=>3,
                  "u_agent_id"=>5,
                  "screen_resolution_id"=>4,
                  "ip_id"=>6)
                end


      expect(url.url_avg_response_time).to eq(25)
    end

end
