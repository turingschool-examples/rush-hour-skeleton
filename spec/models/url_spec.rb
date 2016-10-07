require_relative '../spec_helper'

describe Url do
  it "is invalid without a root url" do
    url = Url.create(path: "test")

    expect(url).to_not be_valid
  end

  it "is invalid without a path" do
    url = Url.create(root_url: "test")

    expect(url).to_not be_valid
  end
end
