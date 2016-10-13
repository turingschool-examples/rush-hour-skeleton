require_relative '../spec_helper'

describe Ip do
  it "is invalid without a IP" do
    ip = Ip.create()

    expect(ip).to_not be_valid
  end
end
