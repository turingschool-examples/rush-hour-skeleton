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

  describe "uniqueness" do
    it "is invalid if browser/operating system pair is not unique" do
      uas1 = UserAgentStat.create(operating_system: "Windows", browser: "Chrome")
      uas2 = UserAgentStat.create(operating_system: "Windows", browser: "Chrome")

      expect(uas2).to_not be_valid
    end

    it "is valid if browser is unique for the operating system " do
      uas1 = UserAgentStat.create(operating_system: "Windows", browser: "Chrome")
      uas2 = UserAgentStat.create(operating_system: "Windows", browser: "Opera")

      expect(uas2).to be_valid
    end

    it "is valid if operating system is unique for the browser " do
      uas1 = UserAgentStat.create(operating_system: "Windows", browser: "Chrome")
      uas2 = UserAgentStat.create(operating_system: "Mac OS", browser: "Chrome")

      expect(uas2).to be_valid
    end
  end

  describe ".breakdown_browsers" do
    it "breaks down all browsers" do
      build_linked_user_agent_stats_and_payloads

      expected = {"Chrome"=>2, "Safari"=>1}
      expect(UserAgentStat.breakdown_browsers).to eq(expected)
    end
  end

  describe ".breakdown_os" do
    it "breaks down all operating systems" do
      build_linked_user_agent_stats_and_payloads
      
      expected = {"Mac OS"=>2, "Windows"=>1}
      expect(UserAgentStat.breakdown_os).to eq(expected)
    end
  end
end
