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

  describe ".average_response_time_for_client" do
    it "returns average response time for client across payloads" do
      client = new_client
      build_payloads_with_real_data

      expect(client.average_response_time_for_client).to eq(44)
    end
  end

  describe ".max_response_time_client_for_client" do
    it "returns max response time for client across payloads" do
      client = new_client
      build_payloads_with_real_data

      expect(client.max_response_time_for_client).to eq(90)
    end
  end

  describe ".min_response_time_client_for_client" do
    it "returns min response time for client across payloads" do
      client = new_client
      build_payloads_with_real_data

      expect(client.min_response_time_for_client).to eq(21)
    end
  end

  describe ".most_frequent_request_type_for_client" do
    it "returns the most frequent request type for client across requests" do
      client = new_client
      build_payloads_with_real_data

      expect(client.most_frequent_request_type_for_client).to eq('GET')
    end
  end

  describe ".all_http_verbs_for_client" do
    it "returns all http verbs for client across requests" do
      client = new_client
      build_payloads_with_real_data

      expect(client.all_http_verbs_for_client).to eq(['GET'])
    end
  end

  describe ".breakdown_browsers_client" do
    it "returns breakdown of browsers for client" do
      client = new_client
      build_payloads_with_real_data

      expect(client.breakdown_browsers_client).to eq(["Chrome: 5 instances"])
    end
  end

  describe ".breakdown_os_client" do
    it "returns breakdown of operating systems for client" do
      client = new_client
      build_payloads_with_real_data

      expect(client.breakdown_os_client).to eq(["Macintosh: 5 instances"])
    end
  end

  describe ".resolutions_for_client" do
    it "returns resolutions for client" do
      client = new_client
      build_payloads_with_real_data

      expect(client.resolutions_for_client).to eq(["1080 x 1920", "700 x 420"])
    end
  end

  describe ".urls_for_client" do
    it "returns all urls for client" do
      client = new_client
      build_payloads_with_real_data

      expect(client.urls_for_client).to eq(["http://google.com/about", "http://google.com/search"])
    end
  end
end
