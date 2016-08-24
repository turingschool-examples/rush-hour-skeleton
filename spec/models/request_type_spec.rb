require './spec/spec_helper'
require './app/models/request_type'

RSpec.describe RequestType, type: :model do
  let(:request_type) { RequestType.new("verb" =>"GET")}

  it "takes a request_type and returns a request_type object" do
    expect(request_type).to be_an_instance_of RequestType
  end

  it "has a request_type verb" do
    expect(request_type.verb).to eq("GET")
  end

  it "will not create a request_type without a request_type" do
    expect(RequestType.new("verb" => "")).to be_invalid
  end

  it "will not allow duplicate verbes" do
    RequestType.create("verb" =>"GET")
    expect(RequestType.new("verb" => "GET")).to be_invalid
  end

end
