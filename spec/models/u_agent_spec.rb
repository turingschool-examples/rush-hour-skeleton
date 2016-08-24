require './spec/spec_helper'
require './app/models/u_agent'

RSpec.describe UAgent, type: :model do
  let(:u_agent) { UAgent.new("browser" =>"Chrome", "operating_system" => "Macintosh")}

  it "takes a u agent and returns a u agent object" do
    expect(u_agent).to be_an_instance_of UAgent
  end

  it "has a u agent browser" do
    expect(u_agent.browser).to eq("Chrome")
  end

  it "has a u agent operating_system" do
    expect(u_agent.operating_system).to eq("Macintosh")
  end

  it "will not create a u agent without a browser" do
    expect(UAgent.new("browser" => "")).to be_invalid
  end

  it "will not create a u agent without a operating_system" do
    expect(UAgent.new("operating_system" => "")).to be_invalid
  end

  it "will not allow duplicate browser" do
    UAgent.create("browser" =>"Chrome")
    expect(UAgent.new("browser" => "Chrome")).to be_invalid
  end

  it "will not allow duplicate operating_system" do
    UAgent.create("operating_system" =>"Macintosh")
    expect(UAgent.new("operating_system" => "Macintosh")).to be_invalid
  end
end
