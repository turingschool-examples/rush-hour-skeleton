require './spec/spec_helper'
require './app/models/client'

RSpec.describe Client, type: :model do

  after :each do
    DatabaseCleaner.clean
  end

  let(:client) { Client.new("identifier" => "jumpstartlab",
                      "root_url" => "www.jumpstartlab.com")}

  it "takes a client and returns a client object" do
    client = Client.new("identifier" => "jumpstartlab",
                        "root_url" => "www.jumpstartlab.com")
    expect(client).to be_an_instance_of Client
  end

  it "has an identifier" do
    expect(client.identifier).to eq("jumpstartlab")
  end

  it "has a root url" do
    expect(client.root_url).to eq("www.jumpstartlab.com")
  end

  it "will not create a client without an identifier" do
    bad_client = Client.new("identifier" => "", "root_url" => "www.jlab.com")
    expect(bad_client).to be_invalid
  end

  it "will not create a client without a root url" do
    bad_client = Client.new("identifier" => "jumpstartlab", "root_url" => "")
    expect(bad_client).to be_invalid
  end

  it "will not allow duplicate identifier" do
    Client.create("identifier" => "jumpstartlab",
      "root_url" => "www.jumpstartlab.com")
    bad_client = Client.new("identifier" => "jumpstartlab",
      "root_url" => "www.jumpstartlab2.com")
    expect(bad_client).to be_invalid
  end

  it "will not allow duplicate root urls" do
    Client.create("identifier" => "jumpstartlab2",
      "root_url" => "www.jumpstartlab.com")
    bad_client = Client.new("identifier" => "jumpstartlab",
      "root_url" => "www.jumpstartlab.com")
    expect(bad_client).to be_invalid
  end

end
