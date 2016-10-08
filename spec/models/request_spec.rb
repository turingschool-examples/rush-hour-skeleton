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
end
