require_relative '../spec_helper'

RSpec.describe "Payload" do

  it "is valid with everything" do
    payload = Payload.new(url: "http://jumpstartlab.com/blog",
                          requestedAt: "2013-02-16 21:38:28 -0700",
                          respondedIn: 37,
                          referredBy: "http://jumpstartlab.com",
                          requestType: "GET",
                          eventName: "socialLogin",
                          userAgent: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          resolutionWidth: 1920,
                          resolutionHeight: 1280,
                          ip:"63.29.38.211")

    expect(payload).to be_valid
  end

  it "is invalid without a url" do
    payload = Payload.new(requestedAt: "2013-02-16 21:38:28 -0700",
                          respondedIn: 37,
                          referredBy: "http://jumpstartlab.com",
                          requestType: "GET",
                          eventName: "socialLogin",
                          userAgent: "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                          resolutionWidth: 1920,
                          resolutionHeight: 1280,
                          ip:"63.29.38.211")

    expect(payload).to_not be_valid
  end

end
