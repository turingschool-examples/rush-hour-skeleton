require_relative '../spec_helper'

RSpec.describe "RequestType" do

  it "is valid with a request_type" do
    request_type = RequestType.new(request_type: "bah")

    expect(request_type).to be_valid
  end

  it "is invalid without a request_type" do
    request_type = RequestType.new()

    expect(request_type).to_not be_valid
  end

  describe ".all_http:verbs" do
    it "returns all used http verbs" do
      RequestType.create(request_type: "GET")
      RequestType.create(request_type: "POST")
      RequestType.create(request_type: "PUT")
      RequestType.create(request_type: "PATCH")
      RequestType.create(request_type: "DELETE")

      expect(RequestType.all_http_verbs).to eq(["GET", "POST", "PUT", "PATCH", "DELETE"])
    end
  end

end
