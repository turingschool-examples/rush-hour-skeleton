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
end
