require './spec/spec_helper'
require './app/models/source'

RSpec.describe Source, type: :model do
  let(:source) { Source.new("address" =>"http://jumpstartlab.com")}

  it "takes a source and returns a source object" do
    expect(source).to be_an_instance_of Source
  end

  it "has a source address" do
    expect(source.address).to eq("http://jumpstartlab.com")
  end

  it "will not create a source without a source" do
    expect(Source.new("address" => "")).to be_invalid
  end

  it "will not allow duplicate addresses" do
    Source.create("address" =>"http://jumpstartlab.com")
    expect(Source.new("address" => "http://jumpstartlab.com")).to be_invalid
  end

end
