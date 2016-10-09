require_relative '../spec_helper'

RSpec.describe "Client" do
  describe "validation" do
    it "is invalid without identifier" do
      client = Client.create(root_url: "www.google.com")

      expect(client).to_not be_valid
    end

    it "is invalid without root_url" do
      client = Client.create(identifier: "google")

      expect(client).to_not be_valid
    end

    it "is valid with all attributes" do
      client = Client.create(identifier: "google", root_url: "www.google.com")

      expect(client).to be_valid

    end

    it "has a unique identifier" do
      client1 = Client.create(identifier: "google", root_url: "www.google.com")
      client2 = Client.create(identifier: "google", root_url: "www.yahoo.com")

      expect(client2).to_not be_valid

    end

    it "has a unique identifer and root_url pair" do
      client1 = Client.create(identifier: "google", root_url: "www.google.com")
      client2 = Client.create(identifier: "google", root_url: "www.google.com")

      expect(client2).to_not be_valid
    end

    it "is valid for unique identifer and root_url pair" do
      client1 = Client.create(identifier: "google", root_url: "www.google.com")
      client2 = Client.create(identifier: "yahoo", root_url: "www.yahoo.com")

      expect(client2).to be_valid
    end

  end
end
