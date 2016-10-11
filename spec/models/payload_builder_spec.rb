require_relative '../spec_helper'

RSpec.describe "PayloadBuilder" do
  describe ".build_event" do
    it "finds or creates event" do
      event_name_data =   {:event_name=>"socialLogin"}

      found = Event.find_by(event_name: event_name_data[:event_name])
      expect(found).to eq(nil)

      built = PayloadBuilder.build_event(event_name_data)
      expect(built[:event_name]).to eq("socialLogin")
    end
  end

  describe ".build_referral" do
    it "finds or creates referral" do
      source_data =   {:referred_by=>"google.com"}

      found = Referral.find_by(source: source_data[:referred_by])
      expect(found).to eq(nil)

      built = PayloadBuilder.build_referral(source_data)
      expect(built[:source]).to eq("google.com")
    end
  end

  describe ".build_request" do
    it "finds or creates request" do
      request_data =   {:request_type=>"GET"}

      found = Request.find_by(request_type: request_data[:request_type])
      expect(found).to eq(nil)

      built = PayloadBuilder.build_request(request_data)
      expect(built[:request_type]).to eq("GET")
    end
  end

  describe ".build_resolution" do
    it "finds or creates resolution" do
      resolution_data =   {:resolution_height=>"2", :resolution_width=>"3"}

      found = Resolution.find_by(height: resolution_data[:resolution_height], width: resolution_data[:resolution_width])
      expect(found).to eq(nil)

      built = PayloadBuilder.build_resolution(resolution_data)
      expect(built[:height]).to eq("2")
      expect(built[:width]).to eq("3")
    end
  end

  describe ".build_url" do
    it "finds or creates URL" do
      url_data =   {:url=>"http://www.google.com"}

      found = Url.find_by(url_address: url_data[:url])
      expect(found).to eq(nil)

      built = PayloadBuilder.build_url(url_data)
      expect(built[:url_address]).to eq("http://www.google.com")
    end
  end

  describe ".build_visitor" do
    it "finds or creates visitor" do
      visitor_data =   {:ip=>"123.456.789.0"}

      found = Visitor.find_by(ip: visitor_data[:ip])
      expect(found).to eq(nil)

      built = PayloadBuilder.build_visitor(visitor_data)
      expect(built[:ip]).to eq("123.456.789.0")
    end
  end

  describe ".build_user_agent_stats" do
    it "finds or creates user agent" do
      user_agent_data =   {:browser=>"Chrome", :operating_system=>"OS10"}

      found = UserAgentStat.find_by(browser: user_agent_data[:browser], operating_system: user_agent_data[:operating_system])
      expect(found).to eq(nil)

      built = PayloadBuilder.build_user_agent_stats(user_agent_data)
      expect(built[:browser]).to eq("Chrome")
      expect(built[:operating_system]).to eq("OS10")
    end

    it "is parsed by user agent gem" do
      user_agent_data2 = {:user_agent=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"}


      built2 = PayloadBuilder.build_user_agent_stats(user_agent_data2)
      expect(built2[:browser]).to eq("Chrome")
      expect(built2[:operating_system]).to eq("Macintosh")
    end

    describe ".find_client" do
      it "finds client" do
        Client.create(identifier: "testclient3", root_url: "whatever3")
        client_data =   "testclient3"

        found = PayloadBuilder.find_client(client_data)
        expect(found).to be_valid
      end
    end

    describe ".build" do
      it "builds payload" do
        Client.create(identifier: "testclient5", root_url: "whatever3")

        payload_data =   {   :url=>"http://google.com/blog",
                             :requested_at=>"2013-02-16 21:38:28 -0700",
                             :responded_in=>39,
                             :referred_by=>"http://jumpstartlab.com",
                             :request_type=>"GET",
                             :event_name=>"socialLogin",
                             :user_agent=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                             :resolution_width=>"1920",
                             :resolution_height=>"1280",
                             :ip=>"63.29.38.211"}

        identifier = "testclient5"

        found = Payload.find_by( requested_at: payload_data[:requested_at], responded_in: payload_data[:responded_in])
        expect(found).to eq(nil)

        built = PayloadBuilder.build(payload_data, identifier)
        expect(built).to be_valid
      end
    end
  end
end
