require_relative '../spec_helper'

describe ReferredBy do
  it "is invalid without a root url" do
    referred_by = ReferredBy.create(path: "test")

    expect(referred_by).to_not be_valid
  end

  it "is invalid without a path" do
    referred_by = ReferredBy.create(root_url: "test")

    expect(referred_by).to_not be_valid
  end
end
