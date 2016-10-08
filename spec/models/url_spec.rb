require_relative '../spec_helper'

RSpec.describe "Url" do
  describe "validation" do
    it "is invalid without url_address" do
      url = Url.create

    expect(url).to_not be_valid
    end

    it "is valid with url_address" do
      url = Url.create( url_address: "www.google.com")

      expect(url).to be_valid
    end

    it "has a unique url address" do
      url1 = Url.create( url_address: "www.google.com")
      url2 = Url.create( url_address: "www.google.com")

      expect(url2).to_not be_valid
    end
  end
end
