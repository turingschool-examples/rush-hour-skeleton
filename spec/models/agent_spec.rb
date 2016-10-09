require_relative '../spec_helper'

RSpec.describe "Agent" do

  it "is valid with a agent" do
    agent = Agent.new(agent: "bah")

    expect(agent).to be_valid
  end

  it "is invalid without an event" do
    agent = Agent.new()

    expect(agent).to_not be_valid
  end


end
