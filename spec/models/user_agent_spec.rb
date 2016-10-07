require_relative '../spec_helper'

describe UserAgent do
  it "is invalid without a user agent" do
    user_agent = UserAgent.create()

    expect(user_agent).to_not be_valid
  end
end
