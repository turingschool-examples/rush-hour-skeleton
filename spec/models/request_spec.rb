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
      request_1 = Request.create(request_type: "GET")
      request_2 = Request.create(request_type: "PUT")
      request_3 = Request.create(request_type: "POST")
      request_4 = Request.create(request_type: "PATCH")
      request_5 = Request.create(request_type: "DELETE")

      expected = ["POST", "GET", "PATCH", "DELETE", "PUT"]
      expect(Request.list_all_http_verbs_used).to eq(expected)
    end

    it "lists each verb only once" do
      request_1 = Request.create(request_type: "GET")
      request_2 = Request.create(request_type: "GET")
      request_3 = Request.create(request_type: "PUT")
      request_4 = Request.create(request_type: "PUT")
      request_5 = Request.create(request_type: "POST")
      
      expected = ["POST", "GET", "PUT"]
      expect(Request.list_all_http_verbs_used).to eq(expected)
    end

  end
end
