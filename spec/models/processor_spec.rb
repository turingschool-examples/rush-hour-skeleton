require_relative '../spec_helper'

RSpec.describe "Processor" do

  it "creates everyhing" do
    Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab")

    params ="{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
    Processor.parse(params, "jumpstartlab")
    expect(Payload.all.count).to eq(1)
  end

  it "creates payload with url" do
  Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab")

  params ="{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
  Processor.parse(params, "jumpstartlab")
    expect(Payload.first.url.url).to eq("http://jumpstartlab.com/blog")
  end

  it "creates payload with referred by" do
  Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab")

  params ="{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
  Processor.parse(params, "jumpstartlab")
    expect(Payload.first.referred_by.referred_by).to eq("http://jumpstartlab.com")
  end

  it "creates payload with request type" do
  Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab")

  params ="{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
  Processor.parse(params, "jumpstartlab")
    expect(Payload.first.request_type.request_type).to eq("GET")
  end

  it "creates payload with event name" do
  Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab")

  params ="{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
  Processor.parse(params, "jumpstartlab")
    expect(Payload.first.event_name.event_name).to eq("socialLogin")
  end

  it "creates payload with user agent" do
  Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab")

  params ="{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
  Processor.parse(params, "jumpstartlab")
    expect(Payload.first.agent.agent).to eq("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
  end

  it "creates payload with resolution" do
  Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab")

  params ="{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
  Processor.parse(params, "jumpstartlab")
    expect(Payload.first.resolution.resolution_width).to eq(1920)
    expect(Payload.first.resolution.resolution_height).to eq(1280)
  end

  it "creates payload with ip" do
  Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab")

  params ="{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
  Processor.parse(params, "jumpstartlab")
    expect(Payload.first.ip.ip).to eq("63.29.38.211")
  end

  it "creates payload with requested at" do
  Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab")

  params ="{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
  Processor.parse(params, "jumpstartlab")
    expect(Payload.first.requested_at).to eq("2013-02-16 21:38:28 -0700")
  end

  it "creates payload with responded in" do
  Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab")

  params ="{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
  Processor.parse(params, "jumpstartlab")
    expect(Payload.first.responded_in).to eq(37)
  end

  it "creates payload with client" do
  Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab")

  params ="{\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com\",\"requestType\":\"GET\",\"eventName\": \"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
  Processor.parse(params, "jumpstartlab")
    expect(Payload.first.client.identifier).to eq("jumpstartlab")
  end

  describe ".uri_path" do
    it "returns just the path part of url" do

      expect(Processor.uri_path("http://beesbeesbees.io/africankillerbees")).to eq("/africankillerbees")
    end
  end

  describe ".rebuild" do
    it "rebuilds a url from a client and path" do
      client = Client.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab")

      expect(Processor.rebuild("jumpstartlab", "/bees")).to eq("http://jumpstartlab/bees")
    end
  end

end
