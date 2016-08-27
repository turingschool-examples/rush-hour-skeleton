require './spec/spec_helper'
require './app/models/ip_address'

RSpec.describe IpAddress, type: :model do

  after :each do
    DatabaseCleaner.clean
  end

  let(:ip_address) { IpAddress.new("address" => "63.29.38.211")}

  it "takes a ip address and returns an ip address object" do
    expect(ip_address).to be_an_instance_of IpAddress
  end

  it "has an address" do
    expect(ip_address.address).to eq("63.29.38.211")
  end

  it "will not create a client without an address" do
    bad_ip_address = IpAddress.new("address" => "")
    expect(bad_ip_address).to be_invalid
  end

  it "will not allow duplicate addresses" do
    good_ip_address = IpAddress.create("address" => "63.29.38.211")
    bad_ip_address = IpAddress.new("address" => "63.29.38.211")
    expect(bad_ip_address).to be_invalid
  end

end
