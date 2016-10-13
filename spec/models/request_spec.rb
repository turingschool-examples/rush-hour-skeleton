require_relative '../spec_helper'

RSpec.describe "Request" do
  describe "validation" do
    it "is invalid without request_type" do
      request = Request.create

      expect(request).to_not be_valid
    end

    it "is valid with request_type" do
      request = Request.create(request_type: "GET")

      expect(request).to be_valid
    end
  end

  describe ".list_all_http_verbs_used" do
    it "lists all http verbs used" do
      build_several_requests

      expected = ["DELETE", "GET", "PATCH", "POST", "PUT"]
      expect(Request.list_all_http_verbs_used).to eq(expected)
    end

    it "lists each verb only once" do
      build_several_requests

      expected = ["DELETE", "GET", "PATCH", "POST", "PUT"]
      expect(Request.list_all_http_verbs_used).to eq(expected)
    end
  end
  describe ".most_frequent_request_type" do
    it "returns most frequent request type" do
      build_several_requests

      expected = "GET"
      expect(Request.most_frequent_request_type).to eq(expected)
    end
  end
end
