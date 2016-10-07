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
  
  
end