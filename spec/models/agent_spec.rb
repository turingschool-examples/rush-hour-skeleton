require_relative '../spec_helper'

describe Agent do
  it "is invalid without a user agent" do
    agent = Agent.create()

    expect(agent).to_not be_valid
  end
end
