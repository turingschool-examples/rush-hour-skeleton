require_relative '../spec_helper'

describe RequestType do
  it "is invalid without a http_verb" do
    request = RequestType.create()

    expect(request).to_not be_valid
  end  
end
