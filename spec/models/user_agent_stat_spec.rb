require_relative '../spec_helper'

RSpec.describe "UserAgentStat" do
  describe "validation" do
    it "is invalid without browser" do
      user_agent_stat = UserAgentStat.create( operating_system: "Windows")

      expect(user_agent_stat).to_not be_valid
    end

    it "is invalid without operating system" do
      user_agent_stat = UserAgentStat.create( browser: "Chrome")

      expect(user_agent_stat).to_not be_valid
    end

    it "is valid with all attributes" do
      user_agent_stat = UserAgentStat.create( operating_system: "Windows", browser: "Chrome")

      expect(user_agent_stat).to be_valid
    end
  end
end
