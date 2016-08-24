require './spec/spec_helper'
require './app/models/url'

RSpec.describe Url, type: :model do
  let(:url) { Url.new("address" =>"http://jumpstartlab.com/blog")}

  it "takes a url and returns a url object" do
    expect(url).to be_an_instance_of Url
  end

  it "has a url address" do
    expect(url.address).to eq("http://jumpstartlab.com/blog")
  end

  it "will not create a url without a url" do
    expect(Url.new("address" => "")).to be_invalid
  end

  it "will not allow duplicate addresses" do
    Url.create("address" =>"http://jumpstartlab.com/blog")
    expect(Url.new("address" => "http://jumpstartlab.com/blog")).to be_invalid
  end

end
